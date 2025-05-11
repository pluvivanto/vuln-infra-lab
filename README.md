# vuln-infra-lab (infra-v1-ec2 branch)

This branch contains the **EC2-based version** of the vulnerable infrastructure lab project.

It demonstrates:

- Infrastructure provisioning using Terraform
- EC2 instance deployment with a fixed Elastic IP
- Docker-based launch of OWASP Juice Shop
- GitHub Actions flow for remote deploy via SSH
- Dynamic security group updates based on GitHub Runner IP
- Automated key management using Terraform

This version intentionally exposes manual DevOps steps to better understand:

- SSH-based CI deployment flows
- Per-IP access control
- EC2 lifecycle and state handling

---

## What’s next

For the ECS-based version with full CI/CD and container-native deployment,  
refer to the `ecs-migration` branch.
