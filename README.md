# TMBDProject

> TMDB API를 활용한 Weekly 영화 순위 및 영화 소개

## 목차
[1.개발 기간](#개발-기간)

[2.개발 환경](#개발-환경)

[3.주요 기능](#주요-기능)

[4.기술스택](#기술스택)

[5.트러블슈팅](#트러블슈팅)

[6.회고](#회고)

[7.추후 업데이트할 내용](#추후-업데이트할-내용)
***
## 개발 기간
> 23.08.22

## 개발 환경
> Xcode 14

## 스크린샷
<img width="645" alt="스크린샷 2023-11-06 오전 1 26 10" src="https://github.com/JaeBeen0725/TMBDProject1/assets/105216574/a0fa5e36-13f9-48a6-b485-a98e15f4128e">

## 주요 기능
- 금주의 영화 순위
- 영화 줄거리 및 등장인물 소개
***

## 기술스택
 - **UIKit** : **StoryBoard** 기반으로 사용자 인터페이스 구현 및 이벤트 관리
 - **Alamofire & TMDB API** : HTTP통신으로 TMDB 영화 데이터 request
 - **Kingfisher**: 비동기 호출후 영화 이미지 데이터를 출력 및 Caching
 - **Codable**: Model에 Protocol을 채택하여 영화 데이터를 Decode

## 트러블슈팅
- APIKey 노출 이슈
-> .gitignore file을 생성후 APIKey file을 github에 노출되지 않도록 설정

- API Respond값이 nil로 인한 movie title이 부분적으로 출력되지 않는 이슈
-> originalTitle 데이터가 nil 일때 name 데이터로 변경하여 출력

~~~
...
cell.movieTitleLabel.text = movieList.results[indexPath.row].originalTitle ?? movieList.results[indexPath.row].name
...
~~~

- genreIDS의 respond가 Int배열로 인한 추가 통신 이슈
-> Dictionary타입으로 프로퍼티를 생성하여 효율적인 request 구성

~~~
let genreList : [Int : String] = [28:"Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction", 10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western" ]
~~~

## 회고
### Good
- Codable에 대한 개념이해
- Open API의 사용

### Bad
- 불필요한 데이터까지 포함한 모델구성
- 통신 예외처리 부족

## 추후 업데이트할 내용
- 순위 Label 생성
- UI개선
- API통신 예외처리

