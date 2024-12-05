import java.io.File
import java.io.InputStream

fun read_file(): List<List<Char>> {
    val inputStream: InputStream = File("input").inputStream()
    val lineList = mutableListOf<String>()

    inputStream.bufferedReader().forEachLine { lineList.add(it) }

    var crossword = mutableListOf<MutableList<Char>>()
    var line_data = mutableListOf<Char>()

    lineList.forEach{
        crossword.add(it.toMutableList())
    }
    return crossword
}

fun main(){
    var crossword = read_file()
    var total_count = 0
    for (line in crossword){
       total_count += check(line)
       total_count += check(line.reversed())
    }
    for (line in transpose(crossword)){
       total_count += check(line)
       total_count += check(line.reversed())
    }

    total_count += check_diag(crossword)
    total_count += check_diag(crossword.reversed())

    println(total_count)
}

fun check_diag(crossword: List<List<Char>>): Int {
    var total_count = 0    

    var col = 0
    var row = 1 

    while (col < crossword[0].size){
        var len = crossword[0].size - col
        var diag = List(len) { j ->
            crossword[j][col+j]
        }
        total_count += check(diag)
        total_count += check(diag.reversed())

        col++
    }

    while (row < crossword[0].size){
        var len = crossword[0].size - row
        var diag = List(len) { i ->
            crossword[row+i][i]
        }
        total_count += check(diag)
        total_count += check(diag.reversed())

        row++
    }
    return total_count
}

fun check(line: List<Char>): Int {
    var count = line.windowed(4)
        .count { String(it.toCharArray()) == "XMAS" }
    return count
}

fun transpose(arr: List<List<Char>>): List<List<Char>>{
    val cols = arr[0].size
    val rows = arr.size
    return List(cols) { j -> 
        List(rows) { i -> 
            arr[i][j]
        }
    }
}


main()

