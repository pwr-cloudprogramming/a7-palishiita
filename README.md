# Ishiita Pal - Elastic Beanstalk and Fargate report

- Course: Cloud programming
- Group: Thursday 3:15 PM
- Date: 23rd May 2024

# Environment architecture

##   Elastic Beanstalk

## AWS Provider Configuration
- **AWS Region**: Configured to `us-east-1`.

## Network Infrastructure
- **Virtual Private Cloud (VPC)**: `app_vpc` with CIDR block `10.0.0.0/16`
  - **Internet Gateway**: `app_gw`
  - **Subnets**:
    - `backend_subnet` (CIDR block: `10.0.1.0/24`, Availability Zone: `us-east-1a`)
    - `frontend_subnet` (CIDR block: `10.0.2.0/24`, Availability Zone: `us-east-1b`)
  - **Route Table**: `app_rt`
    - Routes all traffic (`0.0.0.0/0`) to the internet gateway.
    - Associated with both backend and frontend subnets.

## Security Group Configurations
- **Backend Security Group**: `backend_sg`
  - Incoming traffic: TCP on port `8080` (allowed from `0.0.0.0/0`)
  - Outgoing traffic: All traffic allowed
- **Frontend Security Group**: `frontend_sg`
  - Incoming traffic: TCP on port `3000` (allowed from `0.0.0.0/0`)
  - Outgoing traffic: All traffic allowed

## Elastic Beanstalk Setup
- **Applications**:
  - `backend_app`
  - `frontend_app_v2`
- **Environments**:
  - **Backend Environment**: `backend-env-1`
    - Application: `backend_app`
    - Version: `backend_version`
    - Configurations: VPC, subnet, public IP assignment, service role, supported architectures, instance type, security group.
  - **Frontend Environment**: `frontend-env-1`
    - Application: `frontend_app_v2`
    - Version: `frontend_version`
    - Configurations: VPC, subnet, public IP assignment, service role, supported architectures, instance type, security group.

## S3 Storage for Deployment Packages
- **Bucket**: `appbuckettictactoe`
  - **Objects**:
    - `backend_deploy.zip`
    - `frontend_deploy.zip`

## Application URLs
- **Backend Application URL**: `http://${aws_elastic_beanstalk_environment.backend_env.cname}:8080`
- **Frontend Application URL**: `http://${aws_elastic_beanstalk_environment.frontend_env.cname}:3000`

##   Fargate

## AWS Provider Configuration
- **AWS Region**: Configured to `us-east-1`.

## Network Infrastructure
- **Virtual Private Cloud (VPC)**: `tictactoe_vpc` with CIDR block `10.0.0.0/16`
  - **Internet Gateway**: `tictactoe_gateway`
  - **Subnets**:
    - `tictactoe_subnet1` (CIDR block: `10.0.1.0/24`, Availability Zone: `us-east-1a`)
    - `tictactoe_subnet2` (CIDR block: `10.0.2.0/24`, Availability Zone: `us-east-1b`)
  - **Route Table**: `tictactoe_route_table`
    - Routes all traffic (`0.0.0.0/0`) to the internet gateway.
    - Associated with both subnets.

## Security Group Configurations
- **Backend Security Group**: `backend_sg`
  - Incoming traffic: TCP on ports `8080` and `22` (allowed from `0.0.0.0/0`)
  - Outgoing traffic: All traffic allowed
- **Frontend Security Group**: `frontend_sg`
  - Incoming traffic: TCP on ports `3000` and `22` (allowed from `0.0.0.0/0`)
  - Outgoing traffic: All traffic allowed
- **ALB Security Group**: `alb_sg`
  - Incoming traffic: TCP on ports `3000`, `8080`, and `22` (allowed from `0.0.0.0/0`)
  - Outgoing traffic: All traffic allowed

## Load Balancer Setup
- **Application Load Balancer (ALB)**: `tictactoe-alb`
  - Subnets: `tictactoe_subnet1` and `tictactoe_subnet2`
  - Security Group: `alb_sg`
- **Target Groups**:
  - Backend: `alb-target-gr-back`
  - Frontend: `alb-target-gr-front`
- **Listeners**:
  - Backend Listener: `alb_listener_backend` (port `8080`)
  - Frontend Listener: `alb_listener_frontend` (port `80`)

## ECS Cluster and Services
- **Cluster**: `tictactoe_cluster`
- **Task Definitions**:
  - **Backend Task**: `tictactoe_backend_task`
    - Container: `backend` (port `8080`)
  - **Frontend Task**: `tictactoe_frontend_task`
    - Container: `frontend` (port `80`)
- **Services**:
  - **Backend Service**: `tictactoe_backend_service`
    - Network: `tictactoe_subnet1` and `tictactoe_subnet2`, Security Group: `backend_sg`
    - Load Balancer: `alb-target-gr-back`
  - **Frontend Service**: `tictactoe_frontend_service`
    - Network: `tictactoe_subnet1` and `tictactoe_subnet2`, Security Group: `frontend_sg`
    - Load Balancer: `alb-target-gr-front`

## Application URLs
- **Backend Application URL**: `http://${aws_alb.main.dns_name}:8080`
- **Frontend Application URL**: `http://${aws_alb.main.dns_name}:80`

## Preview


## Reflections

- What did you learn?
  - 
- What obstacles did you overcome?

- What did you help most in overcoming obstacles?

- Was that something that surprised you?
