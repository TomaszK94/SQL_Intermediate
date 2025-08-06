/* 

ROWS 
- Defines window frame based on physical row position
- Counts actual rows before/after current row
- Provides precise control over row inclusion

<window function> OVER(
    PARTITION BY column
    ORDER BY column
    ROWS start_frame)

<window function> OVER(
    PARTITION BY column
    ORDER BY column
    ROWS BETWEEN start_frame AND end_frame)

*/