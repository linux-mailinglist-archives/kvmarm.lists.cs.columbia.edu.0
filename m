Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8144DCD21
	for <lists+kvmarm@lfdr.de>; Thu, 17 Mar 2022 19:02:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83B2149ED7;
	Thu, 17 Mar 2022 14:02:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2if9nNZZZV1o; Thu, 17 Mar 2022 14:02:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B61B49F2E;
	Thu, 17 Mar 2022 14:02:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 77F5749ED7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Mar 2022 14:02:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6y+5S7ILzV5 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Mar 2022 14:02:39 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 170BF49ED4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Mar 2022 14:02:38 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B0151682;
 Thu, 17 Mar 2022 11:02:38 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFC813F7B4;
 Thu, 17 Mar 2022 11:02:37 -0700 (PDT)
Date: Thu, 17 Mar 2022 18:03:07 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] arm/run: Use TCG with qemu-system-arm on
 arm64 systems
Message-ID: <YjN3xyfiLU2RUdGr@monolith.localdoman>
References: <20220317165601.356466-1-alexandru.elisei@arm.com>
 <20220317174507.jt2rattmtetddvsq@gator>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220317174507.jt2rattmtetddvsq@gator>
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Thu, Mar 17, 2022 at 06:45:07PM +0100, Andrew Jones wrote:
> On Thu, Mar 17, 2022 at 04:56:01PM +0000, Alexandru Elisei wrote:
> > From: Andrew Jones <drjones@redhat.com>
> > 
> > If the user sets QEMU=qemu-system-arm on arm64 systems, the tests can only
> > be run by using the TCG accelerator. In this case use TCG instead of KVM.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > [ Alex E: Added commit message ]
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  arm/run | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arm/run b/arm/run
> > index 28a0b4ad2729..128489125dcb 100755
> > --- a/arm/run
> > +++ b/arm/run
> > @@ -10,16 +10,24 @@ if [ -z "$KUT_STANDALONE" ]; then
> >  fi
> >  processor="$PROCESSOR"
> >  
> > -ACCEL=$(get_qemu_accelerator) ||
> > +accel=$(get_qemu_accelerator) ||
> >  	exit $?
> >  
> > -if [ "$ACCEL" = "kvm" ]; then
> > +if [ "$accel" = "kvm" ]; then
> >  	QEMU_ARCH=$HOST
> >  fi
> >  
> >  qemu=$(search_qemu_binary) ||
> >  	exit $?
> >  
> > +if [ "$QEMU" ] && [ -z "$ACCEL" ] &&
> > +   [ "$HOST" = "aarch64" ] && [ "$ARCH" = "arm" ] &&
> > +   [ "$(basename $QEMU)" = "qemu-system-arm" ]; then
> > +	accel=tcg
> > +fi
> > +
> > +ACCEL=$accel
> > +
> >  if ! $qemu -machine '?' 2>&1 | grep 'ARM Virtual Machine' > /dev/null; then
> >  	echo "$qemu doesn't support mach-virt ('-machine virt'). Exiting."
> >  	exit 2
> > -- 
> > 2.35.1
> >
> 
> Ha, OK, I guess you posting this is a strong vote in favor of this
> behavior. I've queued it

Ah, yes, maybe I should've been more clear about it. I think this is more
intuitive for the new users who might not be very familiar with
run_tests.sh internals, and like you've said it won't break existing users
who had to set ACCEL=tcg to get the desired behaviour anyway.

Thanks you for queueing it so fast! Should probably have also mentioned
this as a comment in the commit, but I take full responsibility for
breaking stuff.

Alex

> 
> https://gitlab.com/rhdrjones/kvm-unit-tests/-/commits/arm/queue
> 
> Thanks,
> drew 
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
