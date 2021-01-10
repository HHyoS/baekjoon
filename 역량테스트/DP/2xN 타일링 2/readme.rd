문제 사이트 : https://www.acmicpc.net/problem/11727

설명
  2×n 직사각형을 1×2, 2×1과 2×2 타일로 채우는 방법의 수를 구하는 프로그램을 작성하는 문제입니다.
  [ 2xn 타일링 ] 문제의 확장 문제로 사용하는 블럭이 1x2, 2x1에서 2x2 블록까지 3가지로 확장되었습니다.
  기존에 풀었던 2xn 타일링 문제처럼 피보나치수열로 접근하였고, n이 증가할때마다 1x2 블록이 오른쪽에 사용되는 경우와
  2x1 블록 사용 경우를 고려했던 [ 2xn 타일링 ] 에서 2x2 사용을 추가했을 떄 1x2 블록을 사용하는 것과 동일한 경우 수가
  나타나는 규칙을 확인하였고, 그를 이용ㅎ여 f(x) = f(x-1) + f(x-2)*2 라는 식을 찾아내어 문제를 해결하였습니다.


#include <iostream>


int main(void) {
	int n;
	int arr[1001] = { 0, };
	scanf("%d", &n);
	arr[1] = 1;
	arr[2] = 3;
	for (int a = 3; a <= n; ++a)
		arr[a] = (arr[a - 1] + arr[a - 2]*2)%10007;
	printf("%d", arr[n]);
	return 0;
}


