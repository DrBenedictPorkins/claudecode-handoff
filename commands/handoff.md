Create a comprehensive HANDOFF.md handoff file for this software project session.

**MERGE PROCESS (if ./HANDOFF.md exists):**
1. First create current session summary as described below
2. Read existing ./HANDOFF.md and extract items NOT covered in current session
3. Present user with categorized list: "Include these from previous context?"
   - Outstanding Tasks: [brief list]
   - Previous Decisions: [brief list] 
   - Other Notes: [brief list]
4. Allow user to select which categories/items to include
5. Merge selected historical context into new HANDOFF.md

**SUMMARIZATION STRATEGY**: Use a "flared out" temporal approach where conversation details increase toward the end:
- Early session content: Highly compressed - only final outcomes and key decisions
- Mid session content: Moderate detail - important discoveries and significant changes
- Recent session content: Full detail - complete context, current thinking, active problems, and immediate work

Include:
- **Project Overview**: What we're building, its purpose, and current status
- **Session Goals**: What we set out to accomplish in this session
- **Progress Summary**: What has been completed, modified, or discovered (emphasize recent work)
- **Current State**: Exact status of files, configurations, and running processes
- **Technical Context**: Architecture decisions, dependencies, and important implementation details (focus on recent decisions)
- **Outstanding Tasks**: What still needs to be done, in priority order (prioritize based on recent discussion)
- **Key Decisions Made**: Important choices and their rationale (weight recent decisions heavily)
- **Files Modified**: List of all files changed with brief descriptions of changes
- **Commands Used**: Important commands that were executed (emphasize recent/current commands)
- **Next Steps**: Specific actionable items for continuing the work (derived from latest conversation)
- **Context Notes**: Any important background information, constraints, or considerations
- **Handoff Instructions**: How a new Claude session should approach continuing this work (based on current state)

Also (only if relevant):
- Error Log: Any bugs encountered and how they were resolved
- Testing Status: What's been tested, what hasn't, current test results
- Environment Details: Specific versions, configurations, or setup requirements
- Code Patterns: Established conventions or patterns to follow
- Blocked Items: Things that couldn't be completed and why

**PRIORITY**: Focus heavily on the most recent conversations, current problems being solved, and immediate next actions. Earlier completed or abandoned work should be minimally detailed unless directly relevant to current state.

Format this as a well-structured markdown file that would allow a completely new Claude Code session to understand the project state and continue seamlessly where we left off.