Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA97FC42
	for <lists+kvmarm@lfdr.de>; Fri,  2 Aug 2019 16:32:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D60364A553;
	Fri,  2 Aug 2019 10:32:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iTcN1oInpc37; Fri,  2 Aug 2019 10:32:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B2E234A545;
	Fri,  2 Aug 2019 10:32:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F8554A52E
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Aug 2019 10:32:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wNnW4Bzisiy6 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  2 Aug 2019 10:32:30 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 465EA4A4FD
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Aug 2019 10:32:30 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B82AF1570;
 Fri,  2 Aug 2019 07:32:29 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 4FE283F575; Fri,  2 Aug 2019 07:32:28 -0700 (PDT)
Subject: Re: [PATCH] arm64/kvm: fix -Wimplicit-fallthrough warnings
To: Qian Cai <cai@lca.pw>
References: <1564755788-28485-1-git-send-email-cai@lca.pw>
From: Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <0361d2e8-e57c-5cac-f0ff-5e56675ba71d@kernel.org>
Date: Fri, 2 Aug 2019 15:32:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564755788-28485-1-git-send-email-cai@lca.pw>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, christoffer.dall@linaro.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 02/08/2019 15:23, Qian Cai wrote:
> The commit a892819560c4 ("KVM: arm64: Prepare to handle deferred
> save/restore of 32-bit registers") introduced vcpu_write_spsr32() but
> seems forgot to add "break" between the switch statements and generates
> compilation warnings below. Also, adding a default statement as in
> vcpu_read_spsr32().

See
https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?id=3d584a3c85d6fe2cf878f220d4ad7145e7f89218

The default statement is pretty pointless by construction.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
