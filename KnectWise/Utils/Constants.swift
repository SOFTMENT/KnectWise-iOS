//
//  Constants.swift
//  KnectWise
//
//  Created by Vijay Rathore on 31/12/23.
//

import UIKit


class Constants  {
    
    struct StroyBoard {
        
        static let signInViewController = "signInVC"
        static let tabBarViewController = "tabbarVC"
        static let profileInfo1ViewController = "profile1VC"
        static let profileInfo2ViewController = "profileInfo2VC"
        static let profileInfo3ViewController = "profileInfo3VC"
        static let profileInfo4ViewController = "profileInfo4VC"
       
    
    }
    
    public static let eyeColors = ["Amber", "Blue", "Brown", "Gray", "Green", "Hazel"]
    public static let heights = (140...200).map { "\($0)cm" }
    public static let ages = (18...100).map { "\($0)" }
    public static let ethnicities = ["Asian", "Black", "Hispanic", "Middle Eastern", "Native American", "Pacific Islander", "White", "Other"]
    public static let sexualOrientations = ["Asexual", "Bisexual", "Heterosexual", "Homosexual", "Other", "Pansexual", "Queer"]
    public static let jobTitles = ["Artist", "Doctor", "Engineer", "Manager", "Other", "Salesperson", "Software Engineer", "Teacher"]
    public static let childrenOptions = ["No Children", "Expecting", "Young Children", "Older Children", "Adult Children", "Prefer Not to Say"]
    public static let smokingOptions = ["No", "Never", "Often", "Regularly", "Sometimes", "Trying to quit", "Yes"]
    public static let drinkOptions = ["Never", "No", "Occasionally", "Often", "Regularly", "Socially", "Yes"]
    public static let drugsOptions = ["Never", "No", "Occasionally", "Often", "Regularly", "Yes"]
    public static let educationLevelOptions = ["Associate Degree", "Bachelor's Degree", "Doctorate", "High School", "Master's Degree", "No Formal Education", "Professional Degree", "Some College"]
    public static let religionOptions = ["Agnostic", "Atheist", "Buddhist", "Christian", "Hindu", "Jewish", "Muslim", "Other", "Prefer not to say", "Sikh"]
    public static  let pronounsOptions = ["He/Him", "Other", "She/Her", "They/Them"]
    public static let politicsOptions = ["Apolitical", "Conservative", "Liberal", "Moderate", "Other", "Prefer not to say"]
    public static let interestsOptions = ["Art", "Books", "Cooking", "Crafts", "Cycling", "DIY Projects", "Dancing", "Fashion", "Fitness", "Gaming", "Gardening", "Hiking", "Meditation", "Movies", "Music", "Nature", "Photography", "Sports", "Technology", "Theater", "Traveling", "Volunteering", "Writing", "Yoga"]
    public static let languagesOptions = ["Arabic", "Bengali", "Dutch", "English", "Finnish", "French", "German", "Greek", "Hebrew", "Hindi", "Indonesian", "Italian", "Japanese", "Korean", "Mandarin", "Norwegian", "Polish", "Portuguese", "Punjabi", "Russian", "Spanish", "Swedish", "Thai", "Turkish", "Vietnamese"]
    public static let lookingForOptions = [
        "Art Projects",
        "Business Partnerships",
        "Creative Collaborations",
        "Educational Connections",
        "Event Photography",
        "Freelance Hiring",
        "Friendship",
        "Industry Networking",
        "Investment Opportunities",
        "Job Opportunities",
        "Long-term Relationship",
        "Marriage",
        "Mentorship Opportunities",
        "Music Gigs",
        "Professional Networking",
        "Short-term Relationship",
        "Study Groups",
        "Tutoring",
        "Unemployed - Seeking Work",
        "Volunteering"
    ]
    public static let starSignOptions = ["Aquarius", "Aries", "Cancer", "Capricorn", "Gemini", "Leo", "Libra", "Pisces", "Sagittarius", "Scorpio", "Taurus", "Virgo"]
    public static let exerciseOptions = ["Never", "Occasionally", "Often", "Regularly"]





}
