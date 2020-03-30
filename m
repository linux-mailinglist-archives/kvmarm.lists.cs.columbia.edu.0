Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB01977C3
	for <lists+kvmarm@lfdr.de>; Mon, 30 Mar 2020 11:22:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E7604B224;
	Mon, 30 Mar 2020 05:22:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M7QdES3ey4n2; Mon, 30 Mar 2020 05:22:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B2334B1FA;
	Mon, 30 Mar 2020 05:22:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7ADD74B0BA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 05:22:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWGtNYyJAcGR for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Mar 2020 05:22:56 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C71124B0B8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 05:22:55 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3476A1E97E7AB0E559FA;
 Mon, 30 Mar 2020 17:22:47 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 17:22:39 +0800
Subject: Re: [kvm-unit-tests PATCH v7 09/13] arm/arm64: ITS: Commands
To: Eric Auger <eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-10-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <84493416-7b0d-df3e-df56-cedcbdd72010@huawei.com>
Date: Mon, 30 Mar 2020 17:22:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200320092428.20880-10-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, andre.przywara@arm.com, thuth@redhat.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Eric,

On 2020/3/20 17:24, Eric Auger wrote:
> Implement main ITS commands. The code is largely inherited from
> the ITS driver.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

> +/* ITS COMMANDS */
> +
> +static void its_encode_cmd(struct its_cmd_block *cmd, u8 cmd_nr)
> +{
> +	cmd->raw_cmd[0] &= ~0xffUL;
> +	cmd->raw_cmd[0] |= cmd_nr;
> +}
> +
> +static void its_encode_devid(struct its_cmd_block *cmd, u32 devid)
> +{
> +	cmd->raw_cmd[0] &= BIT_ULL(32) - 1;
> +	cmd->raw_cmd[0] |= ((u64)devid) << 32;
> +}
> +
> +static void its_encode_event_id(struct its_cmd_block *cmd, u32 id)
> +{
> +	cmd->raw_cmd[1] &= ~0xffffffffUL;
> +	cmd->raw_cmd[1] |= id;
> +}
> +
> +static void its_encode_phys_id(struct its_cmd_block *cmd, u32 phys_id)
> +{
> +	cmd->raw_cmd[1] &= 0xffffffffUL;
> +	cmd->raw_cmd[1] |= ((u64)phys_id) << 32;
> +}
> +
> +static void its_encode_size(struct its_cmd_block *cmd, u8 size)
> +{
> +	cmd->raw_cmd[1] &= ~0x1fUL;
> +	cmd->raw_cmd[1] |= size & 0x1f;
> +}
> +
> +static void its_encode_itt(struct its_cmd_block *cmd, u64 itt_addr)
> +{
> +	cmd->raw_cmd[2] &= ~0xffffffffffffUL;
> +	cmd->raw_cmd[2] |= itt_addr & 0xffffffffff00UL;
> +}
> +
> +static void its_encode_valid(struct its_cmd_block *cmd, int valid)
> +{
> +	cmd->raw_cmd[2] &= ~(1UL << 63);
> +	cmd->raw_cmd[2] |= ((u64)!!valid) << 63;
> +}
> +
> +static void its_encode_target(struct its_cmd_block *cmd, u64 target_addr)
> +{
> +	cmd->raw_cmd[2] &= ~(0xfffffffffUL << 16);
> +	cmd->raw_cmd[2] |= (target_addr & (0xffffffffUL << 16));
> +}
> +
> +static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
> +{
> +	cmd->raw_cmd[2] &= ~0xffffUL;
> +	cmd->raw_cmd[2] |= col;
> +}

The command encoding can be refactored like:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d36f136d57aea6f6440886106e246bb7e5918d8

which will look much clearer.

[...]

> +static void its_send_single_command(its_cmd_builder_t builder,
> +				    struct its_cmd_desc *desc)
> +{
> +	struct its_cmd_block *cmd, *next_cmd;
> +
> +	cmd = its_allocate_entry();
> +	builder(cmd, desc);
> +	next_cmd = its_post_commands();
> +
> +	its_wait_for_range_completion(cmd, next_cmd);
> +}
> +
> +

extra line.

> +static void its_build_mapd_cmd(struct its_cmd_block *cmd,
> +			       struct its_cmd_desc *desc)
> +{
> +	unsigned long itt_addr;
> +	u8 size = 12; /* 4096 eventids */

Maybe use desc->its_mapd_cmd.dev->nr_ites instead as we already have it?

> +
> +	itt_addr = (unsigned long)(virt_to_phys(desc->its_mapd_cmd.dev->itt));
> +	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
> +
> +	its_encode_cmd(cmd, GITS_CMD_MAPD);
> +	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
> +	its_encode_size(cmd, size - 1);
> +	its_encode_itt(cmd, itt_addr);
> +	its_encode_valid(cmd, desc->its_mapd_cmd.valid);
> +	its_fixup_cmd(cmd);
> +	if (desc->verbose)
> +		printf("ITS: MAPD devid=%d size = 0x%x itt=0x%lx valid=%d\n",
> +			desc->its_mapd_cmd.dev->device_id,
> +			size, itt_addr, desc->its_mapd_cmd.valid);
> +

extra line.

All of these are trivial things and feel free to ignore them,
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
