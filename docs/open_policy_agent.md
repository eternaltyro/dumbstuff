# OpenPolicyAgent

## Authoring policies using rego

The general format is to begin with a package name - sort of like a
namespace.

```
# policy.rego

package mypolicy
```

An evaluation function start with a name followed by a body. All the
expressions in the body must evaluate to true for the function to return
true. 

```
# policy.rego

package mypolicy

allow {
    1 == 1
    2 == 2
}
```

To evaluate a policy, we can use the following command:

```
$ opa eval --data policy.rego 'data.mypolicy.allow'
{
  "result": [
    {
      "expressions": [
        {
          "value": true,
          "text": "data.mypolicy.allow",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}
```

The boolean value `true` is returned if all expressions are true. But we
can change it to any return type: string, list, etc.

```
# policy.rego

package mypolicy

allow = "yes" {
    1 == 1
    2 == 2
}
```

```
$ opa eval --data policy.rego 'data.mypolicy.allow'
{
  "result": [
    {
      "expressions": [
        {
          "value": "yes",
          "text": "data.mypolicy.allow",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}
```

If the expressions don't evaluate to true, then an empty object is
returned. 

```
# policy.rego

package mypolicy

allow = "yes" {
    1 == 1
    2 == 3
}
```

```
$ opa eval --data policy.rego 'data.mypolicy.allow'
{}
```

We can set a default to force opa to return a failure.

```
# policy.rego

package mypolicy

default allow = "no"

allow = "yes" {
    1 == 1
    2 == 3
}
```

```
$ opa eval --data policy.rego 'data.mypolicy.allow'
{
  "result": [
    {
      "expressions": [
        {
          "value": "no",
          "text": "data.mypolicy.allow",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}
```

We can also return just the return value

```
$ opa eval --format raw --data policy.rego 'data.mypolicy.allow'
no
```

### OpenPolicyAgent v1.0

import rego.v1
fmt --rego-v1
