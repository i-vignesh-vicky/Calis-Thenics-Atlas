# Security Guidelines

> "Security is not a feature. It is a fundamental quality of every feature."

## Purpose

This document defines security principles, standards, and best practices for Calis-Thenics-Atlas.

Users trust us with personal fitness data, body measurements, and health information. Security must be designed in from day one—not added later. Security must be considered throughout the entire development lifecycle: design, implementation, deployment, and maintenance.

We protect:
- User identities
- Personal fitness data
- Authentication credentials
- System integrity
- Business operations

---

## Security Principles

Atlas follows these core security principles:

1. **Secure by Default** — Security is the default state; insecurity requires deliberate bypass
2. **Least Privilege** — Every component has minimum necessary permissions
3. **Defense in Depth** — Multiple security layers so breach of one doesn't compromise all
4. **Zero Trust** — Never assume requests are legitimate; always verify
5. **Privacy First** — Collect minimum necessary data; delete when no longer needed
6. **Fail Securely** — When failures occur, default to the secure state

Security is **proactive**, not reactive.

---

## Authentication

### Supported Methods

**Initial:**
- Email & password
- Google OAuth 2.0
- Apple Sign-In

**Future:**
- Passkeys (passwordless)
- Enterprise SSO

### Password Requirements

- Minimum length: 8 characters
- Common password detection (check against breached password databases)
- Secure password hashing: Argon2 or bcrypt
- Passwords never stored in plaintext
- Password reset requires verification (email, SMS, etc.)

### JWT (JSON Web Tokens)

**Access Tokens:**
- Short-lived (15-60 minutes)
- Signed with cryptographic key
- Never logged or exposed in logs
- Always transmitted over HTTPS

**Refresh Tokens:**
- Longer-lived (days/weeks)
- Rotated after each use
- Revocable if compromise suspected
- Stored securely (not in localStorage when possible)
- Only used over HTTPS

### OAuth Integration

When using OAuth (Google, Apple):
- Validate state parameter to prevent CSRF
- Verify ID token signature
- Map external ID to internal user
- Do not rely solely on email for account linkage

---

## Authorization (RBAC)

### Role-Based Access Control

**Initial Roles:**
- `User` — Standard user (default)
- `Admin` — Platform administrators

**Future Roles:**
- `Coach` — Can provide guidance
- `Moderator` — Community moderation
- `Support` — Customer support agent
- `AIService` — AI system account

### Authorization Rules

Every request must verify:
1. User is authenticated (has valid token)
2. User has required role/permission for the action
3. User can only access their own data (or shared resources)

Example:
```csharp
public async Task<WorkoutDto> GetWorkout(Guid id, Guid requestingUserId)
{
    var workout = await _repository.GetWorkout(id);
    
    if (workout.UserId != requestingUserId && !requestingUser.IsAdmin)
        throw new UnauthorizedException();
    
    return workout;
}
```

---

## HTTPS & Transport Security

**Requirement:** All traffic must use HTTPS.

- Plain HTTP is **not supported**
- HTTPS on all endpoints, including APIs
- Force HTTPS redirect (301/308)
- Enable HSTS (HTTP Strict-Transport-Security) in production
  ```
  Strict-Transport-Security: max-age=31536000; includeSubDomains
  ```
- TLS 1.2 minimum (preferably 1.3)

---

## Secrets Management

**Never hardcode:**
- API keys
- Database connection strings
- JWT signing keys
- OAuth secrets
- Encryption keys
- Third-party service credentials

### Storage

Use secure configuration management:
- Azure Key Vault (recommended)
- AWS Secrets Manager
- Environment variables (development only)
- HashiCorp Vault

### In Source Control

Secrets **must never** be committed:
- Use `.gitignore` for secrets files
- Scan repository history for leaked secrets
- Rotate immediately if any secret is exposed
- Use branch protection rules

### Rotation

- Rotate secrets regularly
- Automate rotation where possible
- Track rotation dates
- Have rollback plan

---

## Data Protection

### PII (Personally Identifiable Information)

Protect all PII:
- Email addresses
- Usernames
- Body measurements (weight, height, body fat %)
- Workout history
- Performance metrics
- Health data

### Encryption

**At Rest:**
- Sensitive data should be encrypted at database level (when practical)
- Encryption keys separate from data
- Key management system for key rotation

**In Transit:**
- All data transmitted over HTTPS
- No unencrypted PII in logs or error messages

### Data Minimization

- Collect only data necessary for feature
- Do not collect "just in case"
- Document why each data element is collected
- Delete data when no longer needed
- Provide data export for users

---

## Privacy & User Control

Users own their data.

Provide:
- ✓ Data export (all user data in standard format)
- ✓ Account deletion (removes PII, may keep anonymized data)
- ✓ Privacy controls (who can see profile, workouts, etc.)
- ✓ Data sharing preferences
- ✓ Marketing opt-out
- ✓ Cookie/tracking opt-out

---

## Input Validation

**Rule:** Never trust client-provided data.

Validate at **all layers**:

**API Boundary:**
```csharp
[HttpPost("/workouts")]
public async Task<WorkoutDto> CreateWorkout([FromBody] CreateWorkoutRequest request)
{
    if (string.IsNullOrEmpty(request.Name))
        return BadRequest("Name is required");
    if (request.Name.Length > 255)
        return BadRequest("Name too long");
}
```

**Application Layer:**
```csharp
public class CreateWorkoutHandler
{
    public async Task Handle(CreateWorkoutCommand cmd)
    {
        if (!WorkoutValidator.IsValid(cmd))
            throw new ValidationException();
    }
}
```

**Domain Layer:**
```csharp
public class Workout
{
    public Workout(string name)
    {
        if (string.IsNullOrEmpty(name))
            throw new DomainException("Name required");
        
        Name = name;
    }
}
```

### Input Validation Includes

- ✓ Length constraints
- ✓ Type validation
- ✓ Range validation (min/max)
- ✓ Format validation (email, URL, phone)
- ✓ Whitelist validation (allowed values)
- ✓ Cross-field validation

---

## SQL Injection Prevention

**Always use parameterized queries:**

**Bad:**
```csharp
string query = $"SELECT * FROM Workouts WHERE UserId = {userId}";
```

**Good:**
```csharp
var workout = await context.Workouts
    .Where(w => w.UserId == userId)
    .ToListAsync();
```

**Rules:**
- Use ORM (Entity Framework) when possible
- If raw SQL, use parameters: `@userId`
- Never concatenate user input into SQL strings
- Review raw SQL carefully

---

## Cross-Site Scripting (XSS) Prevention

Sanitize user-generated content before displaying:

**Examples that need sanitization:**
- Community posts
- Comments
- User bios/descriptions
- Any user-provided text rendered in UI

**Prevention:**
- HTML escape output
- Use templating engines that escape by default
- Content Security Policy (CSP) headers
- Validate and sanitize on backend

---

## Cross-Site Request Forgery (CSRF) Prevention

**For browser clients:**
- Implement CSRF tokens
- SameSite cookie attribute

**For mobile/API clients:**
- JWT in Authorization header (naturally CSRF-resistant)
- No session cookies needed

---

## File Upload Security

Future file uploads must:

- ✓ Validate file type (MIME type + magic bytes)
- ✓ Validate file size
- ✓ Scan for malware (if practical)
- ✓ Store outside application root
- ✓ Use random filenames
- ✓ Serve with correct content-type headers
- ✓ Disable script execution in upload directory

**Never:**
- ✗ Trust file extensions
- ✗ Store in web root
- ✗ Use original filename
- ✗ Allow arbitrary uploads without validation

---

## Rate Limiting

Protect against abuse:

**Endpoints to rate limit:**
- `/auth/login` — Prevent brute force
- `/auth/register` — Prevent account enumeration
- `/auth/forgot-password` — Prevent spam
- `/api/public/*` — Prevent DoS

**Example:**
```
- Max 5 login attempts per email per 15 minutes
- Max 3 registrations per IP per hour
- Max 100 requests per user per minute (general API)
```

---

## Logging & Auditing

### What to Log

Log security-relevant events:
- ✓ Login (successful and failed)
- ✓ Logout
- ✓ Password changes
- ✓ Permission changes
- ✓ Role changes
- ✓ Data export requests
- ✓ Account deletion
- ✓ Suspicious activity

### What NOT to Log

Never log:
- ✗ Passwords (ever)
- ✗ Access tokens or JWT
- ✗ Refresh tokens
- ✗ API keys
- ✗ OAuth secrets
- ✗ Sensitive health/personal data
- ✗ Large request/response bodies

### Log Structure

```json
{
  "timestamp": "2025-01-15T10:30:00Z",
  "level": "INFO",
  "event": "UserLoggedIn",
  "userId": "123e4567-e89b-12d3-a456-426614174000",
  "ipAddress": "192.168.1.1",
  "userAgent": "Mozilla/5.0...",
  "success": true,
  "correlationId": "req-12345"
}
```

---

## Error Handling

Error messages should be informative to legitimate users but not expose internals.

**Bad:**
```
"Unexpected error: SQL Server at 192.168.1.50 connection timeout"
```

**Good:**
```
"An unexpected error occurred. Our team has been notified. Please try again later."
```

Detailed error information goes to logs, not to users.

---

## Dependency Management

- ✓ Keep dependencies updated
- ✓ Monitor for known vulnerabilities (Dependabot, Snyk)
- ✓ Review third-party packages before adoption
- ✓ Remove unused dependencies
- ✓ Pin versions to avoid surprise upgrades
- ✓ Audit licenses for compliance

---

## Security Checklist

Before deploying any feature:

- ✓ Is all user input validated?
- ✓ Are passwords/secrets never logged?
- ✓ Is authorization checked on every action?
- ✓ Is all data encrypted in transit?
- ✓ Are error messages safe?
- ✓ Are dependencies up to date?
- ✓ Is the code reviewed by another engineer?
- ✓ Are security tests in place?

---

## Incident Response

When a security issue is suspected:

1. **Isolate** — Stop the bleeding, contain impact
2. **Assess** — Understand what happened
3. **Notify** — Inform affected users and stakeholders
4. **Remediate** — Fix the issue
5. **Review** — Learn and prevent recurrence

Have a documented security incident response plan.

---

## Third-Party Security

When integrating third-party services:

- ✓ Verify TLS/HTTPS
- ✓ Validate SSL certificates
- ✓ Use API keys / OAuth
- ✓ Monitor for API outages
- ✓ Audit what data is shared
- ✓ Review terms of service
- ✓ Plan for service degradation

---

## Regular Security Review

- Quarterly security reviews
- Annual penetration testing (consider)
- Regular dependency audits
- Security training for team
- Threat model reviews for new features

# API Security

Every protected endpoint must:

- Authenticate the caller
- Authorize the action
- Validate input
- Return appropriate HTTP status codes

Use HTTPS exclusively.

---

# Mobile Security

Store tokens securely using platform-provided secure storage.

Avoid storing sensitive information in:

- Local preferences
- Plaintext files
- Logs

Use secure communication for all API calls.

---

# Data Deletion

When a user requests account deletion:

- Remove personal information where legally permitted
- Retain audit records only when required
- Respect applicable privacy regulations

Deletion workflows should be irreversible after confirmation.

---

# Backups

Database backups must:

- Be encrypted
- Be tested regularly
- Have defined retention periods

Access to backups must be restricted.

---

# Monitoring

Monitor for:

- Repeated failed logins
- Suspicious API usage
- Excessive request rates
- Unauthorized access attempts

Alerts should notify engineers of critical events.

---

# Secure Development Practices

Engineers should:

- Review security implications during design
- Validate all external input
- Follow secure coding standards
- Avoid unnecessary permissions
- Keep secrets out of source code

Security reviews are part of the development process.

---

# AI Security (Future)

AI systems must:

- Respect user privacy
- Avoid exposing personal data
- Explain recommendations where possible
- Never make unsafe training recommendations

AI models should use only the data required for the intended purpose.

---

# Third-Party Integrations

Future integrations (wearables, health platforms, AI providers) must:

- Use secure authentication
- Request minimal permissions
- Handle failures gracefully
- Protect user data during transmission

---

# Incident Response

In the event of a security incident:

1. Detect
2. Contain
3. Investigate
4. Remediate
5. Notify affected users if required
6. Document lessons learned

Every incident should result in process improvements.

---

# Security Checklist

Before releasing a feature:

✓ Authentication implemented

✓ Authorization verified

✓ Input validated

✓ Sensitive data protected

✓ Secrets managed securely

✓ Logs reviewed

✓ Error messages sanitized

✓ Dependencies scanned

✓ Security tests passed

---

# Guiding Principle

Users trust Atlas with their fitness journey.

Protecting that trust is as important as protecting their data.
```

---

# Technical Architect Review

This is a solid foundation, but there are a few enhancements I'd make as Atlas matures:

* **Threat Modeling:** Conduct lightweight threat modeling for major features (authentication, AI, community, payments).
* **OWASP ASVS Alignment:** Gradually align security practices with the OWASP Application Security Verification Standard.
* **Automated Security Scans:** Integrate dependency scanning, secret scanning, and static application security testing (SAST) into CI/CD.
* **API Abuse Protection:** Add bot detection and adaptive rate limiting as public usage grows.
* **Data Classification:** Categorize data (public, internal, confidential, sensitive) to guide handling and storage decisions.

---
