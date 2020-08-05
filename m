Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF4E23CB83
	for <lists+kvmarm@lfdr.de>; Wed,  5 Aug 2020 16:33:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EBAA74B856;
	Wed,  5 Aug 2020 10:33:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C4Xdv3IhN0yS; Wed,  5 Aug 2020 10:33:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C27874B70A;
	Wed,  5 Aug 2020 10:33:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 765814B61C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 10:33:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LfiVipdbRx-5 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Aug 2020 10:33:25 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 551994B5FA
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 10:33:25 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3A5A1424;
 Wed,  5 Aug 2020 07:33:24 -0700 (PDT)
Received: from [192.168.0.57] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2773F7D7;
 Wed,  5 Aug 2020 07:33:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: arm64: nVHE: Don't consume host SErrors with RAS
To: Andrew Scull <ascull@google.com>, kvmarm@lists.cs.columbia.edu
References: <20200730151823.1414808-1-ascull@google.com>
 <20200730151823.1414808-2-ascull@google.com>
From: James Morse <james.morse@arm.com>
Message-ID: <0cbb075a-ab5b-92a2-35bb-c3abb292ac84@arm.com>
Date: Wed, 5 Aug 2020 15:33:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730151823.1414808-2-ascull@google.com>
Content-Language: en-GB
Cc: will@kernel.org, maz@kernel.org, catalin.marinas@arm.com,
 kernel-team@android.com
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

On 30/07/2020 16:18, Andrew Scull wrote:
> The ESB at the start of the vectors causes any SErrors to be consumed to
> DISR_EL1. If the exception came from the host and the ESB caught an
> SError, it would not be noticed until a guest exits and DISR_EL1 is
> checked. Further, the SError would be attributed to the guest and not
> the host.

Yup, this happens because the world has moved underneath this code:

Previously any v8.2 RAS capable system would have been crazy to turn off VHE, so v8.0 and
v8.1 systems had a nop here instead, and v8.2 systems had VHE, so there were no 'from the
host' EL2 vectors.


> To avoid these problems, use a different exception vector for the host
> that does not use an ESB but instead leaves any host SError pending. A
> guest will not be entered if an SError is pending so it will always be
> the host that will receive and handle it.
> 
> Hyp initialization is now passed the vector that is used for the host
> and the vector for guests is stored in a percpu variable as
> kvm_get_hyp_vector() is not suitable for calling from nVHE hyp.

> Fixes: 0e5b9c085dce ("KVM: arm64: Consume pending SError as early as possible")

Surely this can only happen if you had turned VHE off?


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
