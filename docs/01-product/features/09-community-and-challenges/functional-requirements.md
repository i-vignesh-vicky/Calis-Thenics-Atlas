# Community and Challenges - Functional Requirements

## Feature Overview

Community and Challenges creates connection, accountability, and inspiration through shared experiences. Users can build profiles, interact with others, participate in challenges, and support each other's fitness journeys.

### Value Proposition

- Support system for sustained commitment
- Inspiration from others' progress
- Accountability through community
- Recognition for helping others
- Reduced isolation in fitness journey

---

## User Flows

### View Community Feed

1. User navigates to Community
2. User sees feed of recent posts and activity
3. Posts include:
   - Workout completions
   - Milestone achievements
   - Challenge participation
   - Community discussions
4. User can like, comment, or reply

### Create Community Post

1. User taps "Create Post"
2. User writes text content
3. User can optionally:
   - Attach workout data
   - Share achievement
   - Tag exercise or skill
   - Add photo
4. Post published to community feed

### View User Profile

1. User taps on another user or searches for them
2. User sees profile with:
   - Display name and bio
   - Workouts completed
   - Skills achieved
   - Community contributions
   - Following/followers
3. User can follow/unfollow
4. User can send private message (future)

### Browse Challenges

1. User navigates to Challenges
2. User sees active and upcoming challenges
3. For each challenge:
   - Objective and duration
   - Participant count
   - User's status
4. User can join challenge

### Participate in Challenge

1. User joins challenge
2. Challenge appears in active list
3. User's workouts/data count toward challenge
4. User can see leaderboard during challenge
5. On completion, user sees final placement and badge

### View Leaderboard

1. User sees challenge leaderboard
2. Can see top participants
3. Can see own rank and position
4. Leaderboard updates in real-time

---

## Acceptance Criteria

### Community Posts

- User can post text content (max 2000 characters)
- Posts appear in feed immediately
- Posts include timestamp and user info
- User can edit or delete own posts
- Comments/likes count displayed
- Comment threads nested properly

### User Profiles

- User can set display name, bio, avatar
- Workout statistics visible on profile
- Skills achieved listed
- Follower/following counts shown
- Follow/unfollow works bidirectionally

### Challenges

- User can join active challenges
- Participant count updated in real-time
- Leaderboard ranks participants correctly
- Challenge completion awards badge
- Challenges have clear objectives

### Interactions

- Like functionality works smoothly
- Comments persist and display correctly
- Mentions work (@username tagging)
- Notifications sent for mentions and replies

---

## Data Requirements

### User Community Profile

```
id (UUID)
user_id (UUID, foreign key)
display_name (string, unique, indexed)
bio (string, max 500)
avatar_url (string, nullable)
follower_count (integer)
following_count (integer)
post_count (integer)
workout_total (integer)
skills_unlocked (integer)
joined_at (timestamp)
last_active_at (timestamp)
public_profile (boolean)
```

### Community Post

```
id (UUID)
user_id (UUID, foreign key)
content (string, max 2000)
attached_workout_id (UUID, nullable)
attached_achievement_id (UUID, nullable)
image_url (string, nullable)
likes_count (integer)
comments_count (integer)
shares_count (integer)
created_at (timestamp)
updated_at (timestamp)
deleted_at (timestamp, nullable, soft delete)
```

### Challenge Entity

```
id (UUID)
name (string)
description (string)
objective (string)
category (enum: workouts, volume, skill, consistency)
start_date (timestamp)
end_date (timestamp)
goal_value (decimal)
metric_type (enum: workouts_completed, volume, skill_unlock, streak_days)
participant_count (integer)
badge_awarded (string, nullable)
created_by (UUID, foreign key, system for MVP)
```

### User Challenge Participation

```
id (UUID)
user_id (UUID, foreign key)
challenge_id (UUID, foreign key)
joined_at (timestamp)
completed_at (timestamp, nullable)
current_progress (decimal)
rank (integer, nullable)
badge_earned (boolean, default false)
unique constraint on (user_id, challenge_id)
```

### Community Post Comment

```
id (UUID)
post_id (UUID, foreign key)
user_id (UUID, foreign key)
parent_comment_id (UUID, nullable)
content (string, max 1000)
created_at (timestamp)
updated_at (timestamp)
likes_count (integer)
```

### Follow Relationship

```
id (UUID)
follower_id (UUID, foreign key)
following_id (UUID, foreign key)
created_at (timestamp)
unique constraint on (follower_id, following_id)
```

---

## Edge Cases

- User posts then immediately deletes - notification not sent, post hidden from feed
- User comments on deleted post - post removed, comment orphaned
- User joins challenge after halfway - progress counted from join point
- User unfollows then refollows - previous follow history cleared
- User reaches leaderboard #1 then gets dethroned - leaderboard updates
- Duplicate follow attempt - idempotent, no duplicate follows

---

## MVP Scope (v1.0)

### Included

- Community feed with posts
- User profiles with basic stats
- Follow/unfollow functionality
- Like and comment on posts
- 5-10 community challenges per month
- Challenge leaderboards
- Challenge badges/completion tracking
- Basic moderation (flag/report)
- Community guidelines enforcement

### Not Included (v2.0+)

- Direct messaging
- Private group communities
- User-created challenges
- Advanced content filtering
- Recommendation algorithms
- Community reputation system
- Advanced moderation tools

---

## Future Enhancements

### v2.0 - Rich Interactions

- Direct messaging between users
- Private workout groups
- User-created challenges
- Community voting on challenges
- Detailed reputation/karma system
- Advanced content filtering

### v3.0 - Coaching Integration

- Certified coaches offering guidance in community
- Mentorship matching
- Group coaching sessions
- Community expert recognition
- Social proof indicators

---

## Implementation Considerations

### Moderation

- Flag inappropriate content
- Manual review queue for moderation team
- Auto-delete violating content
- User reputation affects content visibility
- Temporary bans for violations

### Performance

- Feed paginated (load 20 posts at a time)
- Leaderboard updated every 5 minutes
- Search results cached
- User profile cached for 1 hour

### Safety

- Never show private email in profile
- User can make profile private
- Blocking functionality (v2.0+)
- Report tools for harassment

### Engagement

- Notifications for likes, comments, mentions
- Badge notifications for challenge completions
- Weekly recap emails (optional)
- Streak notifications

---

## Community Moderation Policy

- No spam or self-promotion
- No harassment or abusive content
- No medical claims
- No commercial solicitation
- Community is reflection-first, not vanity-first
- Celebrate progress, not perfection

---

## Challenge Categories (MVP Examples)

### Consistency Challenge

- "365 Workout Streak"
- Objective: 1 workout per day for 365 days
- Rewards: Badge at 100, 200, 365 days

### Volume Challenge

- "10,000 Rep Challenge"
- Objective: 10,000 total reps in 30 days
- Rewards: Badge upon completion

### Skill Challenge

- "First Pull-Up"
- Objective: Unlock first full pull-up skill
- Rewards: Badge, special recognition

### Group Challenge

- "Founder's Challenge"
- Objective: Complete specific workout program
- Rewards: Badge for completers
