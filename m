Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8602E9A19
	for <lists+kvmarm@lfdr.de>; Mon,  4 Jan 2021 17:08:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D48BC4B2D2;
	Mon,  4 Jan 2021 11:08:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PBM1zIKSnaS1; Mon,  4 Jan 2021 11:08:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A01734B2B5;
	Mon,  4 Jan 2021 11:08:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 208174B238
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 11:08:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kiK6EDWZI2-7 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Jan 2021 11:08:11 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 09CCA4B1B9
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 11:08:11 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DB4C420665;
 Mon,  4 Jan 2021 16:08:09 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kwSOt-005FxL-4b; Mon, 04 Jan 2021 16:08:07 +0000
MIME-Version: 1.0
Date: Mon, 04 Jan 2021 16:08:07 +0000
From: Marc Zyngier <maz@kernel.org>
To: Qian Cai <qcai@redhat.com>
Subject: Re: [PATCH] KVM: arm64: Don't access PMCR_EL0 when no PMU is available
In-Reply-To: <703e1b5f2db1631e8f9c55619909fe66eb069f25.camel@redhat.com>
References: <20201210083059.1277162-1-maz@kernel.org>
 <703e1b5f2db1631e8f9c55619909fe66eb069f25.camel@redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <579c839a0016107af66e704f147f9814@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qcai@redhat.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kernel-team@android.com, sfr@canb.auug.org.au,
 linux-next@vger.kernel.org, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 2021-01-04 15:47, Qian Cai wrote:
> On Thu, 2020-12-10 at 08:30 +0000, Marc Zyngier wrote:
>> We reset the guest's view of PMCR_EL0 unconditionally, based on
>> the host's view of this register. It is however legal for an
>> imnplementation not to provide any PMU, resulting in an UNDEF.
>> 
>> The obvious fix is to skip the reset of this shadow register
>> when no PMU is available, sidestepping the issue entirely.
>> If no PMU is available, the guest is not able to request
>> a virtual PMU anyway, so not doing nothing is the right thing
>> to do!
>> 
>> It is unlikely that this bug can hit any HW implementation
>> though, as they all provide a PMU. It has been found using nested
>> virt with the host KVM not implementing the PMU itself.
>> 
>> Fixes: ab9468340d2bc ("arm64: KVM: Add access handler for PMCR 
>> register")
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Reverting this commit on the top of today's linux-next fixed a qemu-kvm 
> coredump
> issue on TX2 while starting a guest.
> 
> - host kernel .config:
> https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config
> 
> # /usr/libexec/qemu-kvm -name ubuntu-20.04-server-cloudimg -cpu host
> -smp 2 -m 2g
> -drive 
> if=none,format=qcow2,file=./ubuntu-20.04-server-cloudimg.qcow2,id=hd
> -device virtio-scsi -device scsi-hd,drive=hd -cdrom
> ./ubuntu-20.04-server-cloudimg.iso
> -bios /usr/share/AAVMF/AAVMF_CODE.fd -M gic-version=host -nographic
> -nic user,model=virtio,hostfwd=tcp::2222-:22
> 
> qemu-kvm: /builddir/build/BUILD/qemu-4.2.0/target/arm/helper.c:1812:
> pmevcntr_rawwrite: Assertion `counter < pmu_num_counters(env)' failed.

You don't have KVM_ARM_PMU selected in your config, so QEMU cannot
access the PMU registers, and no counters are exposed.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
