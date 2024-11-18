const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const Stripe = require("stripe");

// Initialize Firebase Admin
admin.initializeApp();

// Initialize Stripe
const stripe = Stripe('sk_test_51OSRcrJQly1dljCT92y7D4npWFYbDAdeHk14ZKNAboFg3zbsxOoCaVRim2S0cjY3vi69EWo2Nj9RuQL4PGwUkcEF00hNbG0mqS');

// Create an Express app
const app = express();
app.use(express.json());

// Endpoint to create a new customer
app.post('/create-customer', async (req, res) => {
    try {
        console.log('Received request to create a new customer');
        const customer = await stripe.customers.create();
        console.log('Customer created:', customer.id);
        res.json({ customer });
    } catch (error) {
        console.error('Error creating customer:', error.message);
        res.status(500).json({ error: error.message });
    }
});

// Endpoint to create an Ephemeral Key for a customer
app.post('/create-ephemeral-key', async (req, res) => {
    const { customer_id } = req.body;
    console.log('Received request to create an Ephemeral Key for customer:', customer_id);
    try {
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customer_id },
            { apiVersion: '2022-11-15' } // Replace with your Stripe API version
        );
        console.log('Ephemeral Key created for customer:', customer_id);
        res.json({ ephemeralKey });
    } catch (error) {
        console.error('Error creating Ephemeral Key:', error.message);
        res.status(500).json({ error: error.message });
    }
});

// Endpoint to create a PaymentIntent
app.post('/create-payment-intent', async (req, res) => {
    const { customer_id } = req.body;
    console.log('Received request to create a PaymentIntent for customer:', customer_id);
    try {
        const paymentIntent = await stripe.paymentIntents.create({
            amount: 500, // $5.00 in cents
            currency: 'usd',
            customer: customer_id,
            automatic_payment_methods: { enabled: true },
        });
        console.log('PaymentIntent created with ID:', paymentIntent.id);
        res.json({ clientSecret: paymentIntent.client_secret });
    } catch (error) {
        console.error('Error creating PaymentIntent:', error.message);
        res.status(500).json({ error: error.message });
    }
});

// Export the Express app as an HTTPS function
exports.api = functions.https.onRequest(app);

// On-call function for sending notifications
exports.sendNotification = functions.https.onCall(async (data, context) => {
    const deviceToken = data.deviceToken;
    const title = data.title || "Default Title";
    const body = data.body || "Default Body Message";

    const message = {
        notification: {
            title: title,
            body: body,
        },
        token: deviceToken,
    };

    try {
        const response = await admin.messaging().send(message);
        console.log("Successfully sent message:", response);
        return { success: true, message: "Notification sent successfully" };
    } catch (error) {
        console.error("Error sending message:", error);
        return { success: false, message: "Error sending notification", error };
    }
});
