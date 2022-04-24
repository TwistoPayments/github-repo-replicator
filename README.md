# github-repo-replicator
Twisto Github Action for private repo replication.

## Usage
Add this action to your flow .yaml:
```
      - name: Twisto github-repo-replicator
        uses: twistopayments/github-repo-replicator@v*.*.*
        with:
            upstream_repo: upstream-org/upstream-repo
            upstream_deploykey: ${{ secrets.UPSTREAM_DEPLOYKEY }}
            downstream_repo: downstream-org/downstream-repo
            downstream_deploykey: ${{ secrets.DOWNSTREAM_DEPLOYKEY }}
            stream_branch: my-branch
```
* `upstream_repo`: should be in organization/repo format. (required)
* `upstream_deploykey`: requires pull permissions. (required)
* `downstream_repo`: should be in organization/repo format. (required)
* `downstream_deploykey`: requires push permissions. (required)
* `stream_branch`: name of the branch to stream (optional: defaults to `master`)

