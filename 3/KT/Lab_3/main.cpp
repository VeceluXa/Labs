#include <fstream>
#include <iostream>
#include <regex>
#include <string>

enum TTypes {
    SPACE,
    FUNC,
    MAINNAME,
    LEFTFIGURE,
    RIGHTFIGURE,
    LEFTBRACKET,
    RIGHTBRACKET,
    PRINT,
    STRINGCONST,
    IMP,
    ENDOFLINE,
    //   FMT,
    E,
    PACKAGEBLOCK,
    ERROR
};

const std::regex space(R"( )");
const std::regex func(R"(func)");
const std::regex mainName(R"(main)");
const std::regex leftFigure(R"([{])");
const std::regex rightFigure(R"([}])");
const std::regex leftBracket(R"([(])");
const std::regex rightBracket(R"([)])");
const std::regex print(R"(fmt.Println)");
const std::regex stringConst(R"(\".*\")");
const std::regex imp(R"(import)");
const std::regex endOfLine(R"(\n|\r\n)");
// const std::regex fmt(R"(\"fmt\")");
const std::regex e(R"(;)");
const std::regex packageBlock(R"(package)");
// const std::regex VarName(R"([A-Z,a-z][A-Z,a-z,0-9]*)");

#define countOfRegex 13
std::regex regexes[countOfRegex] = {
    space,        func,  mainName,    leftFigure, rightFigure, leftBracket,
    rightBracket, print, stringConst, imp,        endOfLine,   e,
    packageBlock};

std::ifstream in("in.txt");
std::ofstream out("out.txt");
std::vector<enum TTypes> terms;
int next = 0;
bool errorFlag = false;

bool getTerms(void) {
    std::string str;
    char c;

    std::string line;
    getline(in, line);

    std::string lex = "";

    enum TTypes lastTerm = SPACE;
    enum TTypes newTerm = ERROR;
    bool flag = false;
    int count, length;
    while (!line.empty()) {
        length = line.length();
        for (int i = 0; i < length; i++) {
            c = line.front();
            lex.push_back(c);
            newTerm = ERROR;
            for (int j = 0; j < countOfRegex; j++) {
                if (regex_match(lex, regexes[j])) newTerm = (enum TTypes)j;
            }
            if (newTerm == ERROR && flag) {
                if (lastTerm != SPACE) {
                    terms.push_back(lastTerm);
                }
                lex = "";
                flag = false;
                i--;
            } else {
                if (newTerm != ERROR) flag = true;
                lastTerm = newTerm;
                line.erase(0, 1);
            }
        }
        if (newTerm != ERROR) {
            if (newTerm != SPACE) {
                terms.push_back(lastTerm);
                terms.push_back(ENDOFLINE);
                lex = "";
                flag = false;
            }
        } else {
            if (!errorFlag) {
                printf("Лексическая ошибка\n");
                errorFlag = true;
            }
            return false;
        }
        getline(in, line);
    }
    return true;
}

bool checkTerm(const enum TTypes expected) {
    bool result = (expected == terms[next]);
    next++;
    return result;
}

bool importBlock(void);
bool funcMainBlock(void);
bool operatorBlock1(void);
bool operatorBlock2(void);
bool operatorBlock3(void);
bool operatorBlock4(void);
bool printOperator1(void);
bool printOperator2(void);
bool pacBlock(void);

bool mainBlock(void) {
    bool result = true;
    if (!pacBlock()) result = false;
    if (!importBlock()) result = false;
    if (!funcMainBlock()) result = false;
    return result;
}

bool pacBlock(void) {
    bool result = true;
    if (!checkTerm(PACKAGEBLOCK)) result = false;
    if (!checkTerm(MAINNAME)) result = false;
    if (!checkTerm(ENDOFLINE)) result = false;
    if (!result && !errorFlag) {
        printf("Некорректное объявление пакета\n");
        errorFlag = true;
    }
    return result;
}

bool importBlock(void) {
    bool result = true;
    if (!checkTerm(IMP)) result = false;
    if (!checkTerm(STRINGCONST)) result = false;
    if (!checkTerm(ENDOFLINE)) result = false;
    if (!result && !errorFlag) {
        printf("Некорректное объявление модуля\n");
        errorFlag = true;
    }
    return result;
}

bool funcMainBlock(void) {
    int save = next;
    bool result = true;
    if (!checkTerm(FUNC)) result = false;
    if (!checkTerm(MAINNAME)) result = false;
    if (!checkTerm(LEFTBRACKET)) result = false;
    if (!checkTerm(RIGHTBRACKET)) result = false;
    if (!checkTerm(LEFTFIGURE)) result = false;
    if (!checkTerm(ENDOFLINE)) result = false;
    if (!operatorBlock1()) result = false;
    if (!checkTerm(RIGHTFIGURE)) result = false;
    if (result) return true;
    next = save;
    result = true;
    if (!checkTerm(FUNC)) result = false;
    if (!checkTerm(MAINNAME)) result = false;
    if (!checkTerm(LEFTBRACKET)) result = false;
    if (!checkTerm(RIGHTBRACKET)) result = false;
    if (!checkTerm(LEFTFIGURE)) result = false;
    if (!checkTerm(ENDOFLINE)) result = false;
    if (!operatorBlock2()) result = false;
    if (!checkTerm(RIGHTFIGURE)) result = false;
    if (result) return true;
    next = save;
    result = true;
    if (!checkTerm(FUNC)) result = false;
    if (!checkTerm(MAINNAME)) result = false;
    if (!checkTerm(LEFTBRACKET)) result = false;
    if (!checkTerm(RIGHTBRACKET)) result = false;
    if (!checkTerm(LEFTFIGURE)) result = false;
    if (!checkTerm(ENDOFLINE)) result = false;
    if (!operatorBlock3()) result = false;
    if (!checkTerm(RIGHTFIGURE)) result = false;
    if (result) return true;
    next = save;
    result = true;
    if (!checkTerm(FUNC)) result = false;
    if (!checkTerm(MAINNAME)) result = false;
    if (!checkTerm(LEFTBRACKET)) result = false;
    if (!checkTerm(RIGHTBRACKET)) result = false;
    if (!checkTerm(LEFTFIGURE)) result = false;
    if (!checkTerm(ENDOFLINE)) result = false;
    if (!operatorBlock4()) result = false;
    if (!checkTerm(RIGHTFIGURE)) result = false;
    if (result) return true;
    if (!errorFlag) {
        printf("Неккоректное объявление функции мейн\n");
        errorFlag = true;
    }
    return false;
}

bool operatorBlock1(void) {
    int save = next;
    if (printOperator1() && operatorBlock1()) return true;
    next = save;
    if (printOperator2() && operatorBlock1()) return true;
    next = save;
    if (printOperator1() && operatorBlock2()) return true;
    next = save;
    if (printOperator2() && operatorBlock2()) return true;
    if (printOperator1() && operatorBlock3()) return true;
    next = save;
    if (printOperator2() && operatorBlock3()) return true;
    if (printOperator1() && operatorBlock4()) return true;
    next = save;
    if (printOperator2() && operatorBlock4()) return true;
    return false;
}

bool operatorBlock2(void) {
    int save = next;
    if (printOperator1()) return true;
    next = save;
    if (printOperator2()) return true;
    return false;
}

bool operatorBlock3(void) {
    int save = next;
    if (checkTerm(ENDOFLINE) && operatorBlock1()) return true;
    next = save;
    if (checkTerm(ENDOFLINE) && operatorBlock2()) return true;
    if (checkTerm(ENDOFLINE) && operatorBlock3()) return true;
    if (checkTerm(ENDOFLINE) && operatorBlock4()) return true;
    next = save;
    return false;
}

bool operatorBlock4(void) {
    if (checkTerm(ENDOFLINE)) return true;
    return false;
}

bool printOperator1(void) {
    bool result = true;
    if (!checkTerm(PRINT)) result = false;
    if (!checkTerm(LEFTBRACKET)) result = false;
    if (!checkTerm(STRINGCONST)) result = false;
    if (!checkTerm(RIGHTBRACKET)) result = false;
    if (!checkTerm(ENDOFLINE)) return false;
    return result;
}

bool printOperator2(void) {
    bool result = true;
    if (!checkTerm(PRINT)) result = false;
    if (!checkTerm(LEFTBRACKET)) result = false;
    if (!checkTerm(STRINGCONST)) result = false;
    if (!checkTerm(RIGHTBRACKET)) result = false;
    if (!checkTerm(E)) {
        return false;
    }
    return true;
}

int main() {
    bool flag;
    if (in.is_open() && out.is_open()) {
        next = 0;
        if (getTerms())
            if (!mainBlock())
                printf("ERROR\n");
            else
                printf("SUCCESS\n");
        in.close();
        out.close();
        return 0;
    }
}
