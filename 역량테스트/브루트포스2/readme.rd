문제 사이트 : https://www.acmicpc.net/problem/14391

문제 설명 :
 영선이는 숫자가 쓰여 있는 직사각형 종이를 가지고 있다. 종이는 1×1 크기의 정사각형 칸으로 나누어져 있고, 숫자는 각 칸에 하나씩 쓰여 있다. 행은 위에서부터 아래까지 번호가 매겨져 있고, 열은 왼쪽부터 오른쪽까지 번호가 매겨져 있다.

영선이는 직사각형을 겹치지 않는 조각으로 자르려고 한다. 각 조각은 크기가 세로나 가로 크기가 1인 직사각형 모양이다. 길이가 N인 조각은 N자리 수로 나타낼 수 있다. 가로 조각은 왼쪽부터 오른쪽까지 수를 이어 붙인 것이고, 세로 조각은 위에서부터 아래까지 수를 이어붙인 것이다.

아래 그림은 4×4 크기의 종이를 자른 한 가지 방법이다.



각 조각의 합은 493 + 7160 + 23 + 58 + 9 + 45 + 91 = 7879 이다.

종이를 적절히 잘라서 조각의 합을 최대로 하는 프로그램을 작성하시오.

입력
첫째 줄에 종이 조각의 세로 크기 N과 가로 크기 M이 주어진다. (1 ≤ N, M ≤ 4)

둘째 줄부터 종이 조각이 주어진다. 각 칸에 쓰여 있는 숫자는 0부터 9까지 중 하나이다.

출력
영선이가 얻을 수 있는 점수의 최댓값을 출력한다.

입/출력

예제 입력 1 
2 3
123
312

예제 출력 1 
435


코드 및 설명  // 설명 추가예정
#include <iostream>
using namespace std;

int N, M;
int paper[4][4];

int countMax()
{
	int MAX = 0;
	int sum = 0;
	for(int bitMask = 0; bitMask < (1 << N * M); ++bitMask) {
		//horizonal traverse
		for(int i = 0; i < N; ++i) {
			int tmp = 1;
			for(int j = M - 1; j >= 0; --j) {
				if(~bitMask & (1 << (i * M + j))) {
					sum += tmp * paper[i][j];
					tmp *= 10;
				}
				else tmp = 1;
			}
		}
	
		//vertical traverse
		for(int i = 0; i < M; ++i) {
			int tmp = 1;
			for(int j = N - 1; j >= 0; --j) {
				if(bitMask & (1 << (j * M + i))) {
					sum += tmp * paper[j][i];
					tmp *= 10;
				}
				else tmp = 1;
			}
		}
		if(MAX < sum) MAX = sum;
		sum = 0;
	}
	return MAX;
}

int main()
{
	string temp;
	cin >> N >> M;
	for(int i = 0; i < N; ++i) {
		cin >> temp;
		for(int j = 0; j < M; ++j) 
			paper[i][j] = static_cast<int>(temp[j] - '0');
	}
	cout << countMax();

	return 0;
}
