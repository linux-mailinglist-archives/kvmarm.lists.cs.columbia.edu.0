Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3F1FFAFA
	for <lists+kvmarm@lfdr.de>; Thu, 18 Jun 2020 20:22:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44D354B14E;
	Thu, 18 Jun 2020 14:22:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPj0HcNgw1vt; Thu, 18 Jun 2020 14:22:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C1E14B151;
	Thu, 18 Jun 2020 14:22:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 75C994B14B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 14:22:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hTOMyubTx7ep for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Jun 2020 14:22:41 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 332134B144
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 14:22:41 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B059101E;
 Thu, 18 Jun 2020 11:22:40 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A703F73C;
 Thu, 18 Jun 2020 11:22:39 -0700 (PDT)
Subject: Re: [PATCH] arm64: kvm: Remove kern_hyp_va from get_vcpu_ptr
To: Andrew Scull <ascull@google.com>
References: <20200618093616.164413-1-ascull@google.com>
From: James Morse <james.morse@arm.com>
Message-ID: <451eee30-f9e8-d9ea-5309-580b7aa8cb11@arm.com>
Date: Thu, 18 Jun 2020 19:22:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200618093616.164413-1-ascull@google.com>
Content-Language: en-GB
Cc: maz@kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

Hi Andrew,

On 18/06/2020 10:36, Andrew Scull wrote:
> get_vcpu_ptr is an assembly accessor for the percpu value
> kvm_host_data->host_ctxt.__hyp_running_vcpu. kern_hyp_va only applies to
> nVHE however __hyp_running_vcpu is always assigned a pointer that has
> already had kern_hyp_va applied in __kvm_vcpu_run_nvhe.

So it is!


> kern_hyp_va is currently idempotent as it just masks and inserts the
> tag, but this could change in future and the second application is
> unnecessary.


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
