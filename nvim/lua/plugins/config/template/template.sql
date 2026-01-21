/*
 * FileName:     {{_file_name_}}
 * Author:       {{_author_}}
 * CreatedDate:  {{_date_}}
 * LastModified: 2026-01-06 12:25:51
 * Reference:    8ucchiman.github.io
 * Description:  ---
 */


CREATE TABLE item(
    CODE CHAR(6),
    NAME VARCHAR(40),
    TYPE VARCHAR(10),
    PRICE INT,
    COST INT,
    PRIMARY KEY(CODE)
);

{{_cursor_}}
