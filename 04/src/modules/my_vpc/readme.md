## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.my_net](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | v4\_cidr\_blocks for pass to module | `string` | `""` | no |
| <a name="input_net_name"></a> [net\_name](#input\_net\_name) | Network name for pass to module | `string` | `""` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Zone name for pass to module | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mod_net_id"></a> [mod\_net\_id](#output\_mod\_net\_id) | Output: yandex\_vpc\_network.*.id from module |
| <a name="output_mod_subnet_id"></a> [mod\_subnet\_id](#output\_mod\_subnet\_id) | Output: yandex\_vpc\_subnet.*.id from module |

