; project
; TAB=4

; initialize for disk of fat12 format
    DB      0xeb, 0x4e, 0x90
    DB      "HELLOIPL"          ; ブートセクタの名前を自由に書いて良い(8bytes)
    DW      512                 ; 1セクタの大きさ (must 512)
    DB      1                   ; クラスタの大きさ (must 1 sector)
    DW      1                   ; FATがどこから始まるか(default 1 sector)
    DB      2                   ; FATの個数 (must 2)
    DW      224                 ; ルートディレクトリ領域の大きさ (default 224entry)
    DW      2880                ; このドライブの大きさ (must 2880 sector)
    DB      0xf0                ; メディアタイプ (must 0xf0)
    DW      9                   ; FAT領域の長さ (must 9 sectors)
    DW      18                  ; 1トラックに幾つのセクタがあるか (must 18)
    DW      2                   ; ヘッドの数 (must 2)
    DD      0                   ; パーティションを使ってないのでここは必ず0
    DD      2880                ; ドライブの大きさをもう一度書く
    DB      0, 0, 0x29          ; よくわかんないけどこの値にしておくといいらしい
    DD      0xfffffffff         ; 多分vol.シリアル番号
    DB      "HELLO-OS   "       ; ディスクの名前(11Bytes)
    DB      "FAT12  "           ; フォーマットの名前 (8Bytes)
    RESB    18                  ; とりあえず18Bytes空けておく


; プログラム本体
    DB      0xb8, 0x00, 0x00, 0x8e, 0xd0, 0xbc, 0x00, 0x7c
    DB      0x8e, 0xd8, 0x8e, 0xc0, 0xbe, 0x74, 0x7c, 0x8a
    DB      0x04, 0x83, 0xc6, 0x01, 0x3c, 0x00, 0x74, 0x09
    DB      0xb4, 0x0e, 0xbb, 0x0f, 0x00, 0xcd, 0x10, 0xeb
    DB      0xee, 0xf4, 0xeb, 0xfd


; メッセージ部分
    DB      0x0a, 0x0a          ; 改行を2つ
    DB      "hello, world"
    DB      0x0a                ; 改行
    DB      0

    RESB    0x1fe-$             ; 0x001feまでを0x00で埋める命令

    DB      0x55, 0xaa

; 以下はブートセクタ以外の部分の記述
    DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    4600
    DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    1469432
