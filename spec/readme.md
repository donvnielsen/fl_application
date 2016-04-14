# FL_Logger

FL_Logger provides process logging for FL applications. This class is responsible
for establishing the application/process/event framework. A process must be linked
with a registered application, and it may have multiple events.

The processes and events are simply described by an desc text column. Any unique codes
used to identify processes and events must be formatted into the description. A separate
column is not provided.