BEGIN {
  FS = "|";
  diffcol = 5;
}

{
    for (i = 1; i < diffcol; i++)
        printf $i "|"
    printf service "|"
    if (match($diffcol, /([0-9]+) files? changed/, m))
        printf m[1] "|"
    else
        printf "0|"
    if (match($diffcol, /([0-9]+) insertion/, m))
        printf m[1] "|"
    else
        printf "0|"
    if (match($diffcol, /([0-9]+) deletion/, m))
        printf m[1]
    else
        printf "0"
    print ""
}
