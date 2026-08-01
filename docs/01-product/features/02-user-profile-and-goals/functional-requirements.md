# User Profile and Goals - Functional Requirements

## Feature Overview

User Profile and Goals captures foundational user information needed to personalize the training experience. This includes demographic data, training experience, goals, and equipment context.

### Value Proposition

- Enables personalized recommendations and guidance
- Sets context for appropriate challenge levels
- Forms basis for longitudinal user understanding

---

## User Flows

### Initial Profile Setup

1. User completes registration
2. Prompted to set training experience level
3. User selects primary training goals
4. User specifies available equipment
5. User input saved, profile created

### Profile View

1. User navigates to Profile section
2. User sees personal information, goals, stats summary
3. User can edit any field by tapping "Edit Profile"

### Profile Edit

1. User taps field to edit (experience level, goals, equipment, etc.)
2. User updates information
3. User confirms changes
4. Changes saved and reflected immediately

### Goal Progress View

1. User navigates to Goals section
2. User sees primary goal and progress toward it
3. User can view historical goal data
4. User can adjust goals after reaching them

---

## Acceptance Criteria

### Profile Creation

- User must set experience level (beginner/intermediate/advanced)
- User must select at least one training goal
- User can select multiple training goals
- User can specify equipment availability
- Profile data persists across sessions
- User can update profile at any time

### Profile Display

- All profile information displays accurately
- Last updated timestamp shown for user confidence
- Profile reflects current training goals

### Goal Tracking

- System tracks progress toward stated goals
- Goal progress calculated consistently
- User can modify goals when appropriate
- Historical goal data preserved for reference

---

## Data Requirements

### User Profile Entity

```
id (UUID)
user_id (UUID, foreign key)
first_name (string, nullable)
last_name (string, nullable)
avatar_url (string, nullable)
bio (string, max 500, nullable)
date_of_birth (date, nullable)
gender (enum: male, female, other, prefer_not_to_say, nullable)
country (string, nullable)
experience_level (enum: beginner, intermediate, advanced)
primary_goal (enum)
secondary_goals (array of enum, nullable)
equipment_available (array of strings)
training_frequency_preferred (enum: 2-3x/week, 4-5x/week, daily)
created_at (timestamp)
updated_at (timestamp)
```

### Training Goals Enum

```
strength_gain
endurance
skill_progression
body_composition
consistency_habit
mobility
recovery
challenge_seeking
community_participation
```

### Equipment Options

```
bodyweight_only
parallettes
pull_up_bar
rings
resistance_bands
dumbbells
barbell
bench
other_specify
```

---

## Edge Cases

- User profile incomplete during onboarding - allow progression but prompt for completion
- User has conflicting goals - allow multiple goals, system suggests balanced approach
- User selects "no equipment" then later mentions having equipment - allow update without penalty
- User deletes and recreates account - new profile starts fresh
- User changes goals monthly - system accommodates frequent goal updates
- User has no equipment available - suggest bodyweight programs only

---

## MVP Scope (v1.0)

### Included

- Experience level (beginner/intermediate/advanced)
- Primary and secondary training goals (max 3)
- Available equipment checklist
- Basic profile information (name, avatar, optional bio)
- Profile edit capability
- Goal summary dashboard

### Not Included (v2.0+)

- Advanced metrics (body metrics like height, weight)
- Injury history tracking
- Dietary preferences
- Sleep tracking integration
- Wearable device integration
- Detailed achievement badges by goal type

---

## Future Enhancements

### v2.0 - Rich Profiles

- Body metrics (height, weight, age) for personalized recommendations
- Injury history and limitations
- Training history import
- Profile visibility settings (public/private)
- Followers/following system

### v3.0 - Advanced Personalization

- Dynamic goal adjustment based on performance
- Recommendation engine tailored to profile
- Achievement tracking by goal
- Comparative stats (vs similar users, with privacy controls)

---

## Implementation Considerations

### Data Integrity

- Validate experience level is from allowed enum
- Validate selected goals exist in system
- Ensure equipment selections are from approved list

### Performance

- Profile fetch should be <100ms
- Profile updates should be <500ms
- Cache profile data aggressively on client

### Personalization Hook

- Store profile data in way that enables ML models to use it
- Goal data drives recommendation algorithms
- Experience level affects UI complexity and content difficulty

### Validation

- All profile data should be validated on both client and server
- Empty selections handled gracefully
- Profile completeness tracked for user nudges

---

## User Experience Considerations

- Make profile setup quick (2-3 minutes maximum)
- Allow skip for optional fields, circle back later
- Show how goals inform experience and recommendations
- Let users feel their profile shapes the app
