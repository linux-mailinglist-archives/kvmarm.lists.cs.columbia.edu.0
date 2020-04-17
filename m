Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A4E721ADC04
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 13:17:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B2664B133;
	Fri, 17 Apr 2020 07:17:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m7PmO9wU+1NR; Fri, 17 Apr 2020 07:17:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25BD84B28A;
	Fri, 17 Apr 2020 07:17:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F3CAC4B287
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 07:17:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N+MfHYg5KUiz for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 07:17:25 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E1CAB4B286
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 07:17:25 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72186C14;
 Fri, 17 Apr 2020 04:17:25 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 004173F6C4;
 Fri, 17 Apr 2020 04:17:23 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] KVM: arm: vgic: Only use the virtual state when
 userspace accesses enable bits
To: Marc Zyngier <maz@kernel.org>
References: <20200417083319.3066217-1-maz@kernel.org>
 <20200417083319.3066217-4-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <040579d5-151f-5263-9f5f-69f86965dfc6@arm.com>
Date: Fri, 17 Apr 2020 12:17:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200417083319.3066217-4-maz@kernel.org>
Content-Language: en-GB
Cc: Julien Grall <julien@xen.org>, kvm@vger.kernel.org,
 Andre Przywara <Andre.Przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On 17/04/2020 09:33, Marc Zyngier wrote:
> There is no point in accessing the HW when writing to any of the
> ISENABLER/ICENABLER registers from userspace, as only the guest
> should be allowed to change the HW state.
> 
> Introduce new userspace-specific accessors that deal solely with
> the virtual state.
> 
> Reported-by: James Morse <james.morse@arm.com>

Tested on both machines I've hit this on:
Tested-by: James Morse <james.morse@arm.com>

and perhaps more useful:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
