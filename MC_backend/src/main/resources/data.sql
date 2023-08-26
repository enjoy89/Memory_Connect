
insert into test(test_id, test_question)
values(1, "성함을 말씀해주세요.");

insert into test(test_id, test_question)
values(2, "오늘이 무슨 요일인지 말씀해주세요.");

insert into test(test_id, test_question)
values(3, "지금 계신 이 장소는 어떤 곳인가요?");

insert into test(test_id, test_question)
values(4, "지금 생각 나는 물건 3가지를 말씀해주세요.");

insert into test(test_id, test_question)
values(5, "이번 문제는 계산 문제입니다. '100 - 7' 계산 결과는 무엇일까요?");

insert into test(test_id, test_question)
values(6, "길에서 남의 주민등록증을 주웠다고 했을 때, 어떻게 하면 주인에게 찾아줄 수 있을까요?");

insert into test(test_id, test_question)
values(7, "5각형을 손으로 그려주세요.");

insert into test(test_id, test_question)
values(8, "4번 문항에서 답변했던 물건 3가지를 다시 말씀해주세요.");

insert into test(test_id, test_question)
values(9, "세 가지 사물 이름을 부르세요: 사과, 키위, 바나나.");

insert into test(test_id, test_question)
values(10, "이 문장을 반복해 주세요: 오늘은 날씨가 매우 좋습니다.");

insert into test(test_id, test_question)
values(11, "앞으로 5년 후에 몇 살이 되실 건가요?");

insert into test(test_id, test_question)
values(12, "현재 년도는 무엇인가요?");

insert into test(test_id, test_question)
values(13, "뒤집어서 /'세계/'라고 쓰세요.");

insert into test(test_id, test_question)
values(14, "오늘은 무슨 요일인가요?");

insert into test(test_id, test_question)
values(15, "세 가지 명령을 따르세요: 종이를 접어서 두 번 넘기세요.");

insert into test(test_id, test_question)
values(16, "사과, 망아지, 탁자 중 과일을 고르세요.");

insert into test(test_id, test_question)
values(17, "다음 순서대로 수를 말씀해주세요: 2, 4, 6, ...");

insert into test(test_id, test_question)
values(18, "거꾸로 /'학교/'를 쓰세요.");

insert into test(test_id, test_question)
values(19, "이전에 어떤 도시에 살았는지 말해보세요.");

insert into test(test_id, test_question)
values(20, "7월, 8월, 9월은 어떤 계절인가요?");

insert into test(test_id, test_question)
values(21, "역방향으로 숫자를 세어보세요: 20, 19, 18, ...");

insert into test(test_id, test_question)
values(22, "/'반지/'의 첫 번째 글자를 말해보세요.");

insert into test(test_id, test_question)
values(23, "/'의자/'를 철자대로 말씀해주세요.");

insert into test(test_id, test_question)
values(24, "15와 7을 더해주세요.");

insert into test(test_id, test_question)
values(25, "9에서 3을 뺀 값을 계산해보세요.");

insert into test(test_id, test_question)
values(26, "/'사과, 핸드백, 노트북/' 중 과일을 고르세요.");

insert into test(test_id, test_question)
values(27, "/'우산/'의 두 번째 글자를 말해보세요.");

insert into test(test_id, test_question)
values(28, "3, 6, 9, ... 다음 숫자는 무엇인가요?");

insert into test(test_id, test_question)
values(29, "/'사과, 연필, 노트/' 중 과일을 고르세요.");

insert into test(test_id, test_question)
values(30, "역순으로 일요일부터 세어보세요: 일요일, 토요일, ...");

insert into test(test_id, test_question)
values(31, "/'창문/'의 두 번째 글자를 말해보세요.");

insert into test(test_id, test_question)
values(32, "/'자전거/'를 따라서 말씀해보세요.");

insert into test(test_id, test_question)
values(33, "/'골프/'의 첫 번째 글자를 말해보세요.");

insert into test(test_id, test_question)
values(34, "6과 9를 더하세요.");

insert into test(test_id, test_question)
values(35, "/'바다, 하늘, 호수/'중 소금과 관련된 단어를 찾아보세요.");

insert into test(test_id, test_question)
values(36, "/'컴퓨터/'의 세 번째 글자를 말해보세요.");

insert into test(test_id, test_question)
values(37, "/'강아지, 고양이, 쥐/' 중 설치류와 관련된 단어를 찾아보세요.");

insert into test(test_id, test_question)
values(38, "/'노래, 춤, 음식/' 중 밥과 관련된 단어를 찾아보세요.");

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(1, '이찬호', 26, '남', now());

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(2, '김다빈', 25, '여', now());

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(3, '이성호', 25, '남', now());

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(4, '전두이', 24, '여', now());

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(5, '고우라', 24, '여', now());

insert into place(place_id, place_name, place_location, place_latitude, place_longitude)
values(1, '주사랑노인복지센터', '강원 춘천시 동내면 세실로 62-3', 37.863259047992344, 127.75942706748984);

insert into place(place_id, place_name, place_location, place_latitude, place_longitude)
values(2, '천수노인복지센터', '강원 춘천시 두하길 22', 37.87617086082469, 127.74152747982255);

insert into place(place_id, place_name, place_location, place_latitude, place_longitude)
values(3, '춘천효사랑요양원', '강원 춘천시 춘천로 306-5', 37.881310923076924, 127.74718567872758);


