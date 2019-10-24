Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 24ACCE3774
	for <lists+kvmarm@lfdr.de>; Thu, 24 Oct 2019 18:09:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C4E94A73A;
	Thu, 24 Oct 2019 12:09:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64OLbi0tqYHy; Thu, 24 Oct 2019 12:09:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DC5C54A60D;
	Thu, 24 Oct 2019 12:09:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6EAC64A5A3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Oct 2019 12:09:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NGnYuLin473I for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Oct 2019 12:09:50 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 376304A529
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Oct 2019 12:09:50 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3E8E28;
 Thu, 24 Oct 2019 09:09:49 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81AF33F71F;
 Thu, 24 Oct 2019 09:09:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] arm64: KVM: Reorder system register restoration
 and stage-2 activation
To: Marc Zyngier <maz@kernel.org>
References: <20191019095521.31722-1-maz@kernel.org>
 <20191019095521.31722-3-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <e835b1bf-b2b2-c0e7-f34c-e0a68f921ffd@arm.com>
Date: Thu, 24 Oct 2019 17:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191019095521.31722-3-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hi Marc,

On 19/10/2019 10:55, Marc Zyngier wrote:
> In order to prepare for handling erratum 1319367, we need to make
> sure that all system registers (and most importantly the registers
> configuring the virtual memory) are set before we enable stage-2
> translation.
> 
> This results in a minor reorganisation of the load sequence, without
> any functional change.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
