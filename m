Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 55F884BFAE8
	for <lists+kvmarm@lfdr.de>; Tue, 22 Feb 2022 15:27:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6CAE4A3A5;
	Tue, 22 Feb 2022 09:27:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4-5Mgk7w98z; Tue, 22 Feb 2022 09:27:49 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC2FF4B121;
	Tue, 22 Feb 2022 09:27:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 038874B106
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 09:27:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fADIwmnBuT5J for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Feb 2022 09:27:44 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B0084A3A5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 09:27:44 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8610139F;
 Tue, 22 Feb 2022 06:27:43 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A9483F5A1;
 Tue, 22 Feb 2022 06:27:42 -0800 (PST)
Date: Tue, 22 Feb 2022 14:28:06 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH kvmtool v3] aarch64: Add stolen time support
Message-ID: <YhTy9j+4HIsnrsSG@monolith.localdoman>
References: <YhS2Htrzwks/allO@google.com>
 <YhTsGfoAh4NDo8+j@monolith.localdoman>
 <d5a3d28a964813bd28c79c63e8e3b247@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5a3d28a964813bd28c79c63e8e3b247@kernel.org>
Cc: will@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Tue, Feb 22, 2022 at 02:18:40PM +0000, Marc Zyngier wrote:
> On 2022-02-22 13:58, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Tue, Feb 22, 2022 at 10:08:30AM +0000, Sebastian Ene wrote:
> > > This patch adds support for stolen time by sharing a memory region
> > > with the guest which will be used by the hypervisor to store the
> > > stolen
> > > time information. The exact format of the structure stored by the
> > > hypervisor is described in the ARM DEN0057A document.
> > > 
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > ---
> > >  Changelog since v2:
> > >  - Moved the AARCH64_PVTIME_* definitions from arm-common/kvm-arch.h
> > > to
> > >    arm64/pvtime.c as pvtime is only available for arm64.
> > > 
> > >  Changelog since v1:
> > >  - Removed the pvtime.h header file and moved the definitions to
> > > kvm-cpu-arch.h
> > >    Verified if the stolen time capability is supported before
> > > allocating
> > >    and mapping the memory.
> > > 
> > >  Makefile                               |  1 +
> > >  arm/aarch64/arm-cpu.c                  |  1 +
> > >  arm/aarch64/include/kvm/kvm-cpu-arch.h |  1 +
> > >  arm/aarch64/pvtime.c                   | 89
> > > ++++++++++++++++++++++++++
> > >  arm/kvm-cpu.c                          | 14 ++--
> > >  5 files changed, 99 insertions(+), 7 deletions(-)
> > >  create mode 100644 arm/aarch64/pvtime.c
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index f251147..e9121dc 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -182,6 +182,7 @@ ifeq ($(ARCH), arm64)
> > >  	OBJS		+= arm/aarch64/arm-cpu.o
> > >  	OBJS		+= arm/aarch64/kvm-cpu.o
> > >  	OBJS		+= arm/aarch64/kvm.o
> > > +	OBJS		+= arm/aarch64/pvtime.o
> > >  	ARCH_INCLUDE	:= $(HDRS_ARM_COMMON)
> > >  	ARCH_INCLUDE	+= -Iarm/aarch64/include
> > > 
> > > diff --git a/arm/aarch64/arm-cpu.c b/arm/aarch64/arm-cpu.c
> > > index d7572b7..326fb20 100644
> > > --- a/arm/aarch64/arm-cpu.c
> > > +++ b/arm/aarch64/arm-cpu.c
> > > @@ -22,6 +22,7 @@ static void generate_fdt_nodes(void *fdt, struct
> > > kvm *kvm)
> > >  static int arm_cpu__vcpu_init(struct kvm_cpu *vcpu)
> > >  {
> > >  	vcpu->generate_fdt_nodes = generate_fdt_nodes;
> > > +	kvm_cpu__setup_pvtime(vcpu);
> > >  	return 0;
> > >  }
> > > 
> > > diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h
> > > b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> > > index 8dfb82e..b57d6e6 100644
> > > --- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
> > > +++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> > > @@ -19,5 +19,6 @@
> > > 
> > >  void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init
> > > *init);
> > >  int kvm_cpu__configure_features(struct kvm_cpu *vcpu);
> > > +void kvm_cpu__setup_pvtime(struct kvm_cpu *vcpu);
> > > 
> > >  #endif /* KVM__KVM_CPU_ARCH_H */
> > > diff --git a/arm/aarch64/pvtime.c b/arm/aarch64/pvtime.c
> > > new file mode 100644
> > > index 0000000..247e4f3
> > > --- /dev/null
> > > +++ b/arm/aarch64/pvtime.c
> > > @@ -0,0 +1,89 @@
> > > +#include "kvm/kvm.h"
> > > +#include "kvm/kvm-cpu.h"
> > > +#include "kvm/util.h"
> > > +
> > > +#include <linux/byteorder.h>
> > > +#include <linux/types.h>
> > > +
> > > +#define AARCH64_PVTIME_IPA_MAX_SIZE	SZ_64K
> > > +#define AARCH64_PVTIME_IPA_START	(ARM_MEMORY_AREA - \
> > > +					 AARCH64_PVTIME_IPA_MAX_SIZE)
> > 
> > This doesn't change the fact that it overlaps with KVM_PCI_MMIO_AREA,
> > which is
> > exposed to the guest in the DTB (see my reply to v2).
> 
> Yup, this is a bit of a problem, and overlapping regions are
> a big no-no. Why can't the pvtime region be dynamically placed
> after the RAM (after checking that there is enough space to
> register it in the IPA space)?

In theory, is there something to stop someone from creating a VM with enough
memory to reach the end of the IPA space?

Thanks,
Alex

> 
> Thanks,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
