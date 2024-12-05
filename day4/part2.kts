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

    crossword.forEachIndexed { row, line ->
        line.forEachIndexed{ col, char ->
            if (char == 'A' && row+1 < crossword.size && row-1 >= 0  && col+1 < crossword[row].size && col-1 >= 0){
                total_count += check(crossword[row-1][col-1],
                      crossword[row-1][col+1],
                      crossword[row+1][col-1],
                      crossword[row+1][col+1])
            }
        }
    }

    println(total_count)
}


fun check(x1: Char, x2: Char, y1: Char, y2: Char): Int {
    if(setOf(x1,x2,y1,y2) == setOf('M', 'S')){
        if(x1 == x2 && y1 == y2 || x1 == y1 && x2 == y2){
            return 1
        }
    }
    return 0
}


main()

