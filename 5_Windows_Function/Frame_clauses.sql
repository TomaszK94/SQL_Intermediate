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


start_frame & end_frame :

- CURRENT ROW - Just the current row
- UNBOUNDED PRECEDING - All rows from start to current row
- UNBOUNDED FOLLOWING - All rows from current to end
- N PRECEDING - N rows before current row
- N FOLLOWING - N rows after current row

*/