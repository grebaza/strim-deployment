# Kafka Ecosystem Configuration

## Components

- Broker cluster: Kafka nodes.
- Connect Producer: or adapter producer cluster.
- Connect Consumer cluster: or adapter consumer cluster.
- Schema Registry.
- Broker Console (Kowl): webapp for admin Kafka ecosystem.

## Configuration

Ansible templates are employed to generate Docker Compose YAML scripts. The
`extra_host` key in Docker Compose scripts helps avoid registering host names
of peer node in `/etc/hosts` files. Only the hostnames related to the
Schema Registry are aliased, following the pattern `sr-{node number}`. Broker's
`extra_host` keys don't include the same broker's hostname to avoid network
redirection by Docker.

## Setup diagram
```mermaid
flowchart LR
    CM[[configuration\nmanagement]] -->|setups by pushing\nDocker Compose| Host(cloud\nnode)
    GA(Github\nActions) -->|pulls from| CM
    CM -->|uses| SD[[strim\ndeployment]]
    SD -->|mentions| SC[[strim\ncontainers]]
    SC -->|pushes into| DH(Docker\nHub)
    SI[[strim\ninfrastructure]] -->|send creation\ncommands| CV
    subgraph vendors
        GA -->|checkout into| Host
        CV(Cloud\nVendor) -->|creates| Host
        Host -->|pulls from| DH
    end
    CM -.->|sync\nresource sizes| SI
    CM -->|uses| PN[[push\nnotification]]
```

## Service commands

### Kafka Connect Api endpoints

#### Test server

```bash
curl -sH "Accept:application/json" http://sr:8083/
```

#### Get connector list

```bash
curl -sH "Accept:application/json" http://sr:8083/connectors/
```

#### Create a connector

```bash
curl -i -X POST -sH "Accept:application/json" \
     -sH  "Content-Type:application/json" \
     http://sr:8083/connectors/ \
     -d @connector-settings.json
```
