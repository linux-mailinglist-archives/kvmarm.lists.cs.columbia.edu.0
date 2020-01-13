Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 94135138F1B
	for <lists+kvmarm@lfdr.de>; Mon, 13 Jan 2020 11:31:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 40AF14AECB;
	Mon, 13 Jan 2020 05:31:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ij-b-j5iDspz; Mon, 13 Jan 2020 05:31:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 014134AED7;
	Mon, 13 Jan 2020 05:31:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EFC094AEC9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 05:31:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1YNncJIfPRIT for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Jan 2020 05:31:25 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE3B44AC68
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 05:31:25 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DFF713D5;
 Mon, 13 Jan 2020 02:31:25 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.52])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 571363F534;
 Mon, 13 Jan 2020 02:31:23 -0800 (PST)
Date: Mon, 13 Jan 2020 10:31:18 +0000
From: Steven Price <steven.price@arm.com>
To: yezengruan <yezengruan@huawei.com>
Subject: Re: [PATCH v2 3/6] KVM: arm64: Support pvlock preempted via shared
 structure
Message-ID: <20200113103117.GA44375@arm.com>
References: <20191226135833.1052-1-yezengruan@huawei.com>
 <20191226135833.1052-4-yezengruan@huawei.com>
 <468e2bb4-8986-5e1e-8c4a-31aa56a9ae4f@arm.com>
 <c479977c-3824-4b53-ef46-300d59ac35de@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c479977c-3824-4b53-ef46-300d59ac35de@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Sat, Jan 11, 2020 at 07:30:42AM +0000, yezengruan wrote:
> Hi Steve,
> 
> On 2020/1/9 23:02, Steven Price wrote:
> > On 26/12/2019 13:58, Zengruan Ye wrote:
> >> Implement the service call for configuring a shared structure between a
> >> VCPU and the hypervisor in which the hypervisor can tell the VCPU is
> >> running or not.
> >>
> >> The preempted field is zero if 1) some old KVM deos not support this filed.
> > 
> > NIT: s/deos/does/
> 
> Thanks for posting this.
> 
> > 
> > However, I would hope that the service call will fail if it's an old KVM not simply return zero.
> 
> Sorry, I'm not sure what you mean. The service call will fail if it's an old KVM, and the Guest will use __native_vcpu_is_preempted.

You previously said the "field is zero if [...] some old KVM does not
support this field". This seems a bit of an odd statement, because the
field just doesn't exist (it's an old KVM so won't have allocated it),
and if the guest attempts to find the field using the service call then
the call will fail.

So I'm not sure in what situation you are expecting the field to be zero
on an old KVM.

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
