문제 사이트 :https://www.acmicpc.net/problem/15988


설명
  정수 4를 1, 2, 3의 합으로 나타내는 방법은 총 7가지가 있다. 합을 나타낼 때는 수를 1개 이상 사용해야 한다.

  1+1+1+1
  1+1+2
  1+2+1
  2+1+1
  2+2
  1+3
  3+1
  정수 n이 주어졌을 때, n을 1, 2, 3의 합으로 나타내는 방법의 수를 구하는 프로그램을 작성하시오.
  
  1,2,3을 이용하여 주어진 숫자를 만들 수 있는 숫자 조합의 수를 구하는 문제였습니다.
  
  목표 숫자를 x 라고 가정하고 해당 수를 1,2,3의 합으로 나타내는 방법의 수는 처음에 1을 사용하고 남은 수의 경우의 수를 구하면
  f(x-1)개, 2를 사용하고 남은 수의 경우의 수 f(x-2)개, 3을 사용하고 남은 수의 경우의 수는 f(x-3)개로 나타나는 규칙을
  찾아내어 해당 규칙을 이용하여 문제를 해결하였습니다.
  
  프로그램의 동작은 처음 입력받을 수를 n에 저장하고, 입력받은 숫자(target)가 현재 배열 작성이 완료된 위치인 index보다
  클경우 36~37번 라인의 for문을 수행하고, index에 target값을 입력하여 index를 최신화한 뒤, 작성이 완료된 arr[target]값을 print하도록 구현하였고,
  target값이 현재 작성이 완료된 index값보다 작을 경우, for문을 수행하지않고 arr배열에서 arr[target]값을 바로 출력하도록 하였습니다.
  
#include <stdio.h>
using namespace std;
int main() {
    int n;
    int arr[1000000 + 1] = { 0,1,2,4, };
    scanf("%d",&n);
    int target;
    int index = 3;
    for (int a = 0; a < n; ++a) {
        scanf("%d", &target);
        if (target > index) {
            for (int b = index + 1; b <= target; ++b) {
                arr[b] = ((arr[b - 2] + arr[b - 3]) % 1000000009+arr[b - 1]) % 1000000009;
            }
            index = target;
            printf("%d\n", arr[target]);
        }
        else
            printf("%d\n", arr[target]);
    }

    return 0;
}

  해결과정의 문제
  1. int arr 배열을 arr[1000001] 로 만들때 int main()에서 발생하는 메모리 초과 문제
    해당 문제는 arr[100000 + 1]로 변형하여 문제를 해결하였습니다. 
    이 방법 외에는 arr배열을 0번부터 사용하여 arr[target 숫자-1]로 저장하여 사용하는 방법도 있습니다.
  
  2. 34번 줄의 메모리 초과문제
    해당 라인의 코드를 처음 작성할때에는 arr[b] = (arr[b - 2] + arr[b - 3]+arr[b - 1]) % 1000000009;
    로 작성했었는데, 해당 식처럼 작성 시 int범위를 넘어가는 케이스가 존재하여 34번 라인의 코드처럼 각 더하기하다 한번씩 나누기 연산하여 문제를 해결하였습니다
    int 배열을 long long배열이나 long 배열로 선언시 위 코드처럼 연산을 하지않아도 되나, 그럴경우 메모리의 사용이 두배가까지 커지는 현상이 발생하여 위의 코드로 
    문제해결을 마무리 하였습니다.
   
  3. 메모리 사용 문제
    초기에는 include 를 할 때 iostream을 불러와 사용하여 문제를 해결했습니다.
    하지만 다른 사람들의 메모리 사용과 동작시간 등을 확인했을 떄 저와 코드가 크게 다를것이 없음에도 불구하고
    제 코드가 메모리 사용량이 더 많은것을 보고 수정해본 결과 stdio.h를 include 했을 때 동작시간은 같은 반면 메모리 사용이 5804Kb에서
    4904KB로 900KB 적어짐을 알 수 있었습니다.
  
