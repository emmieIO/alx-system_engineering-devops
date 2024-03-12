# Postmortem: Web Stack Outage on March 10, 2024

## Issue Summary:
- **Duration**: March 10, 2024, 12:00 PM - 4:30 PM (PST)
- **Impact**: The primary service impacted was our user authentication system, resulting in 30% of users experiencing login failures or delays.

## Root Cause:
The root cause of the outage was an unexpected surge in database connections due to a misconfigured connection pool setting.

## Timeline:
- **12:00 PM**: Issue detected through a spike in error rates on the user authentication service.
- **12:05 PM**: Engineers receive automated monitoring alerts indicating increased latency.
- **12:10 PM**: Initial investigation focuses on network issues, ruling out external factors.
- **12:30 PM**: Assumed a potential DDoS attack and began isolating affected servers.
- **1:00 PM**: Escalated the incident to the DevOps team for further assistance.
- **1:30 PM**: Misleadingly pursued a lead on a recent code deployment causing the issue.
- **2:00 PM**: Identified the misconfigured database connection pool as the probable cause.
- **3:00 PM**: Applied a temporary fix by adjusting the connection pool settings to reduce strain.
- **4:00 PM**: Normalized user authentication services and verified successful logins.
- **4:30 PM**: Incident officially resolved.

## Root Cause and Resolution:
The issue stemmed from an unexpectedly high number of open connections to the database server, overwhelming its capacity. This was due to an incorrect configuration setting in the connection pool, allowing connections to remain open indefinitely.

To resolve the problem, we immediately adjusted the connection pool settings to limit the maximum number of concurrent connections and implemented automatic closing of idle connections after a set period.

## Corrective and Preventative Measures:
- **Configuration Review**: Conduct a thorough review of all connection pool configurations across our services to ensure optimal settings.
- **Monitoring Enhancements**: Improve monitoring tools to provide early warnings for database connection spikes.
- **Automated Scaling**: Implement automated scaling mechanisms for database resources to handle unexpected spikes in traffic.
- **Documentation Update**: Update documentation to include best practices for configuring connection pools to prevent future incidents.
- **Training**: Schedule a training session for the team on identifying and troubleshooting database connection issues.

## Next Steps:
1. Patch connection pool configurations across all services.
2. Implement stricter monitoring thresholds for database connections.
3. Develop a playbook for handling similar incidents in the future.
4. Conduct a post-incident review meeting to discuss lessons learned and areas of improvement.

This postmortem serves as a learning experience for our team, emphasizing the importance of robust monitoring, quick detection, and effective troubleshooting in maintaining our web stack's reliability.

We apologize for any inconvenience caused and thank our users for their patience during this outage.
