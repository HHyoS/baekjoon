문제 사이트 : https://www.acmicpc.net/problem/2580

설명 : 스도쿠는 18세기 스위스 수학자가 만든 '라틴 사각형'이랑 퍼즐에서 유래한 것으로 현재 많은 인기를 누리고 있다. 이 게임은 아래 그림과 같이 가로, 세로 각각 9개씩 총 81개의 작은 칸으로 이루어진 정사각형 판 위에서 이뤄지는데, 게임 시작 전 일부 칸에는 1부터 9까지의 숫자 중 하나가 쓰여 있다.



나머지 빈 칸을 채우는 방식은 다음과 같다.

각각의 가로줄과 세로줄에는 1부터 9까지의 숫자가 한 번씩만 나타나야 한다.
굵은 선으로 구분되어 있는 3x3 정사각형 안에도 1부터 9까지의 숫자가 한 번씩만 나타나야 한다.
위의 예의 경우, 첫째 줄에는 1을 제외한 나머지 2부터 9까지의 숫자들이 이미 나타나 있으므로 첫째 줄 빈칸에는 1이 들어가야 한다.



또한 위쪽 가운데 위치한 3x3 정사각형의 경우에는 3을 제외한 나머지 숫자들이 이미 쓰여있으므로 가운데 빈 칸에는 3이 들어가야 한다.



이와 같이 빈 칸을 차례로 채워 가면 다음과 같은 최종 결과를 얻을 수 있다.



게임 시작 전 스도쿠 판에 쓰여 있는 숫자들의 정보가 주어질 때 모든 빈 칸이 채워진 최종 모습을 출력하는 프로그램을 작성하시오.

입력
아홉 줄에 걸쳐 한 줄에 9개씩 게임 시작 전 스도쿠판 각 줄에 쓰여 있는 숫자가 한 칸씩 띄워서 차례로 주어진다. 스도쿠 판의 빈 칸의 경우에는 0이 주어진다. 스도쿠 판을 규칙대로 채울 수 없는 경우의 입력은 주어지지 않는다.

출력
모든 빈 칸이 채워진 스도쿠 판의 최종 모습을 아홉 줄에 걸쳐 한 줄에 9개씩 한 칸씩 띄워서 출력한다.

스도쿠 판을 채우는 방법이 여럿인 경우는 그 중 하나만을 출력한다.

입력 / 출력

입력
아홉 줄에 걸쳐 한 줄에 9개씩 게임 시작 전 스도쿠판 각 줄에 쓰여 있는 숫자가 한 칸씩 띄워서 차례로 주어진다. 스도쿠 판의 빈 칸의 경우에는 0이 주어진다. 스도쿠 판을 규칙대로 채울 수 없는 경우의 입력은 주어지지 않는다.

출력
모든 빈 칸이 채워진 스도쿠 판의 최종 모습을 아홉 줄에 걸쳐 한 줄에 9개씩 한 칸씩 띄워서 출력한다.

스도쿠 판을 채우는 방법이 여럿인 경우는 그 중 하나만을 출력한다.

제한
baekjoon의 백트래킹 알고리즘으로 풀 수 있는 입력만 주어진다. 다음은 그 알고리즘의 수행 시간이다.

예제 입력 1 
0 3 5 4 6 9 2 7 8
7 8 2 1 0 5 6 0 9
0 6 0 2 7 8 1 3 5
3 2 1 0 4 6 8 9 7
8 0 4 9 1 3 5 0 6
5 9 6 8 2 0 4 1 3
9 1 7 6 5 2 0 8 0
6 0 3 7 0 1 9 5 2
2 5 8 3 9 4 7 6 0
예제 출력 1 
1 3 5 4 6 9 2 7 8
7 8 2 1 3 5 6 4 9
4 6 9 2 7 8 1 3 5
3 2 1 5 4 6 8 9 7
8 7 4 9 1 3 5 2 6
5 9 6 8 2 7 4 1 3
9 1 7 6 5 2 3 8 4
6 4 3 7 8 1 9 5 2
2 5 8 3 9 4 7 6 1




코드

#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;
 
int sudoku_arr[9][9] = { 0 };
 
// 수도쿠 값을 출력해준다. 
void print_sudoku() {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            cout << sudoku_arr[i][j];
            if (j != 8)
                cout<<  " ";
        }
        cout << endl;
    }
}
 
void sudoku_slove(int row, int col) {
    // 위치에서 가능한 값을 체크한다. (가능한 값을 배열에 넣자)
    int used_num_arr[9] = { 0 };
    vector<int> each_round_can_vec;
 
    // 가로 세로 체크 
    for (int i = 0; i < 9; i++) {
        if (sudoku_arr[row][i])        used_num_arr[sudoku_arr[row][i] -1 ] = 1;
        if (sudoku_arr[i][col])        used_num_arr[sudoku_arr[i][col] -1 ] = 1;
    }
 
    // 그룹의 첫번째 시작놈을 기준으로 인덱스 설정 
    int sub_row = row / 3, sub_col = col / 3;
    sub_row *= 3;  sub_col *= 3;
 
    // 그룹 체크 
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (sudoku_arr[sub_row][sub_col + j ])        used_num_arr[sudoku_arr[sub_row][sub_col + j] -1 ] = 1; 
        }
        sub_row++; 
    }
 
    // 사용되지 않은 숫자들을 전부 벡터에 넣어준다. 
    for (int i = 0; i < 9; i++) {
        if (!used_num_arr[i]) each_round_can_vec.push_back(i+1);
    }
 
    // 사용되지 않은 숫자가 없으면 그냥 리턴하고, 있으면 해당 위치에 값을 넣고 재귀함수로 다음 단계로 간다. 
    if (!each_round_can_vec.size()) return;
 
 
    //  다음 단계로 넘어간다. 
    int next_row=row, next_col=col;
    while (true) {
        // 다음 컬럼이 9가 되면 
        if ((++next_col) == 9) {
            next_row++;
            next_col = 0;
            // 만약 모든 수가 끝났다면, 프린트하고 종료한다. 
            if (next_row == 9) {
                sudoku_arr[row][col] = each_round_can_vec[0];
                print_sudoku();
                exit(0);
            }
        }
        if (next_row == 9) break;
        if (sudoku_arr[next_row][next_col] == 0) break;
    }
 
 
    for (int i = 0; i < each_round_can_vec.size(); i++) {
        sudoku_arr[row][col] = each_round_can_vec[i];
        sudoku_slove(next_row, next_col);
        sudoku_arr[row][col] = 0;
    }
 
}
 
int main() {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            cin >> sudoku_arr[i][j];
        }
    }
    
    // 그룹 체크 
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (sudoku_arr[i][j] == 0) {
                sudoku_slove(i, j);
            }
        } 
    }
    return 0;
}
