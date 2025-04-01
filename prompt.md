## Prompt for MODEL - Meeting Transcript Analysis & Feedback

**Task:** Analyze the provided meeting transcript and generate a concise summary focusing on key insights.  
Additionally, provide constructive feedback on the meeting's effectiveness and suggest improvements for future meetings.

**Instructions:**

1.  **Transcript Input:**  
{{TRANSCRIPT}}

2.  **Summary (Key Insights - Max 3-5 bullet points):**  Summarize the *most important* decisions, key discussion 
points, and any significant outcomes from the meeting.  Focus on what *needed* to be communicated and what was agreed 
upon.  Prioritize actionable information.

3.  **Meeting Effectiveness Feedback (2-3 paragraphs):**  Evaluate the meeting's overall effectiveness. Consider the 
following:
    *   Was the agenda followed?
    *   Were all relevant topics addressed?
    *   Was the discussion productive and focused?
    *   Were there any areas where the discussion drifted or became unproductive?
    *   Were the right people present?

4.  **Recommendations for Improvement (3-5 bullet points):**  Suggest specific changes to improve future meetings.  
Consider:
    *   Agenda structure and timing
    *   Pre-reading materials
    *   Facilitation techniques
    *   Attendee preparation
    *   Desired outcomes and metrics

**Output Format:**  Please present your analysis in a markdown format, clearly separated into the sections above.  Use 
headings and bullet points for clarity.

**Example (Illustrative - $MODEL should generate its own content based on the transcript):**

## Meeting Summary - Key Insights

*   [Insight 1 - e.g., "Decision made to prioritize Project Alpha."]
*   [Insight 2 - e.g., "Timeline for Phase 1 confirmed."]
*   [Insight 3 - e.g., "Risk assessment for potential delays identified."]

## Meeting Effectiveness Feedback

[Detailed paragraph evaluating the meeting's flow, engagement, and overall success.]

## Recommendations for Improvement

*   [Recommendation 1 - e.g., "Implement a stricter timekeeping mechanism for each agenda item."]
*   [Recommendation 2 - e.g., "Distribute pre-reading materials related to key discussion points."]
*   [Recommendation 3 - e.g., "Assign a note-taker to capture key decisions and action items."]

---

**Important Notes for $MODEL:**

*   **Use the transcript provided above.**
*   **Be concise and focused on actionable insights.**
*   **Maintain a professional and constructive tone.**
*   **Adapt the length of the sections to fit the meeting’s complexity.**
