Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A44014D438B
	for <lists+kvmarm@lfdr.de>; Thu, 10 Mar 2022 10:28:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E220249E1B;
	Thu, 10 Mar 2022 04:28:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4JQvoQic7hRh; Thu, 10 Mar 2022 04:28:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 510D349E21;
	Thu, 10 Mar 2022 04:28:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B00349E1B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 04:28:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T0pyD-PTUxBO for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Mar 2022 04:28:04 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 336B249E1A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 04:28:04 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB0961650;
 Thu, 10 Mar 2022 01:28:02 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C09D43FA20;
 Thu, 10 Mar 2022 01:28:01 -0800 (PST)
Date: Thu, 10 Mar 2022 09:28:24 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 2/2] arm/run: Fix using
 qemu-system-aarch64 to run aarch32 tests on aarch64
Message-ID: <YinEjQJE9m62JpnU@monolith.localdoman>
References: <20220309162117.56681-1-alexandru.elisei@arm.com>
 <20220309162117.56681-3-alexandru.elisei@arm.com>
 <20220309165812.46xmnjek72yrv3g6@gator>
 <Yijf5TlbOKhV+Mw6@monolith.localdoman>
 <20220310065941.2na6kig2o5hxh4vx@gator>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220310065941.2na6kig2o5hxh4vx@gator>
Cc: pbonzini@redhat.com, thuth@redhat.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

Hi,

On Thu, Mar 10, 2022 at 07:59:41AM +0100, Andrew Jones wrote:
> On Wed, Mar 09, 2022 at 05:12:05PM +0000, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Wed, Mar 09, 2022 at 05:58:12PM +0100, Andrew Jones wrote:
> > > On Wed, Mar 09, 2022 at 04:21:17PM +0000, Alexandru Elisei wrote:
> > > > From: Andrew Jones <drjones@redhat.com>
> > > > 
> > > > KVM on arm64 can create 32 bit and 64 bit VMs. kvm-unit-tests tries to
> > > > take advantage of this by setting the aarch64=off -cpu option. However,
> > > > get_qemu_accelerator() isn't aware that KVM on arm64 can run both types
> > > > of VMs and it selects qemu-system-arm instead of qemu-system-aarch64.
> > > > This leads to an error in premature_failure() and the test is marked as
> > > > skipped:
> > > > 
> > > > $ ./run_tests.sh selftest-setup
> > > > SKIP selftest-setup (qemu-system-arm: -accel kvm: invalid accelerator kvm)
> > > > 
> > > > Fix this by setting QEMU to the correct qemu binary before calling
> > > > get_qemu_accelerator().
> > > > 
> > > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > > [ Alex E: Added commit message, changed the logic to make it clearer ]
> > > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > > ---
> > > >  arm/run | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/arm/run b/arm/run
> > > > index 2153bd320751..5fe0a45c4820 100755
> > > > --- a/arm/run
> > > > +++ b/arm/run
> > > > @@ -13,6 +13,11 @@ processor="$PROCESSOR"
> > > >  ACCEL=$(get_qemu_accelerator) ||
> > > >  	exit $?
> > > >  
> > > > +# KVM for arm64 can create a VM in either aarch32 or aarch64 modes.
> > > > +if [ "$ACCEL" = kvm ] && [ -z "$QEMU" ] && [ "$HOST" = "aarch64" ]; then
> > > > +	QEMU=qemu-system-aarch64
> > > > +fi
> > > > +
> > > >  qemu=$(search_qemu_binary) ||
> > > >  	exit $?
> > > >  
> > > > -- 
> > > > 2.35.1
> > > >
> > > 
> > > So there's a bug with this patch which was also present in the patch I
> > > proposed. By setting $QEMU before we call search_qemu_binary() we may
> > > force a "A QEMU binary was not found." failure even though a perfectly
> > > good 'qemu-kvm' binary is present.
> > 
> > I noticed that search_qemu_binary() tries to search for both
> > qemu-system-ARCH_NAME and qemu-kvm, and I first thought that qemu-kvm is a
> > legacy name for qemu-system-ARCH_NAME.
> > 
> > I just did some googling, and I think it's actually how certain distros (like
> > SLES) package qemu-system-ARCH_NAME, is that correct?
> 
> Right

Thanks for confirming it!

> 
> > 
> > If that is so, one idea I toyed with (for something else) is to move the error
> > messages from search_qemu_binary() to the call sites, that way arm/run can first
> > try to find qemu-system-aarch64, then fallback to qemu-kvm, and only after both
> > aren't found exit with an error. Just a suggestion, in case you find it useful.
> 
> We don't have to move the error messages, even if we want to use
> search_qemu_binary() as a silent check. We can just call it with
> a &>/dev/null and then check its return code. I still need to
> allocate some time to think more about this though.

Sure, I'll review and test whatever you come up with.

Thanks,
Alex

> 
> Thanks,
> drew
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
