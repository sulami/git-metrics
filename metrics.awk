BEGIN {
  FS = "|";
  diffcol = 5;
}

{
    for (i = 1; i < diffcol; i++)
        printf "%s|", $i
    printf service "|"
    if (match($diffcol, /([0-9]+) files? changed/, m))
        printf "%d|", m[1]
    else
        printf "0|"
    if (match($diffcol, /([0-9]+) insertion/, m))
        printf "%d|", m[1]
    else
        printf "0|"
    if (match($diffcol, /([0-9]+) deletion/, m))
        printf "%d\n", m[1]
    else
        printf "0\n"
}
