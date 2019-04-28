let _, _, parse =
  [%graphql
    {|
query issueMilestone($owner: String!, $repo: String!, $number: Int!) {
  repository(owner: $owner, name: $repo) {
    issue(number: $number) {
      id
      milestone {
        id
      }
      timelineItems(itemTypes: [CLOSED_EVENT], last: 1) {
        nodes {
          __typename
          ... on ClosedEvent {
            closer {
              __typename
              ... on PullRequest {
                milestone {
                  id
                }
              }
              ... on Commit {
                associatedPullRequests(first: 2) {
                  nodes {
                    milestone {
                      id
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
      |}]

let response =
  Yojson.Basic.from_string
    "{\n\
    \  \"data\": {\n\
    \    \"repository\": {\n\
    \      \"issue\": {\n\
    \        \"id\": \"MDU6SXNzdWUyNjY0Mzc1ODA=\",\n\
    \        \"milestone\": {\n\
    \          \"id\": \"MDk6TWlsZXN0b25lMzUxMjY4MQ==\"\n\
    \        },\n\
    \        \"timelineItems\": {\n\
    \          \"nodes\": [\n\
    \            {\n\
    \              \"__typename\": \"ClosedEvent\",\n\
    \              \"closer\": null\n\
    \            }\n\
    \          ]\n\
    \        }\n\
    \      }\n\
    \    }\n\
    \  }\n\
     }"

let obj = parse response
