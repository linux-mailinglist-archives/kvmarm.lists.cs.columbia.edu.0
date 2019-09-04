Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5F1A85E5
	for <lists+kvmarm@lfdr.de>; Wed,  4 Sep 2019 17:05:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77E754A533;
	Wed,  4 Sep 2019 11:05:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H8eFvLMe046h; Wed,  4 Sep 2019 11:05:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FCEF4A5AC;
	Wed,  4 Sep 2019 11:05:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6FB884A551
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Sep 2019 11:05:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V7Qfpqnu4YpP for <kvmarm@lists.cs.columbia.edu>;
 Wed,  4 Sep 2019 11:05:19 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D95E24A533
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Sep 2019 11:05:19 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65F2C28;
 Wed,  4 Sep 2019 08:05:19 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 230793F59C;
 Wed,  4 Sep 2019 08:05:13 -0700 (PDT)
Subject: Re: [PATCH v4 02/10] KVM: arm/arm64: Factor out hypercall handling
 from PSCI code
To: kbuild test robot <lkp@intel.com>
References: <20190830084255.55113-3-steven.price@arm.com>
 <201909021437.rO6o0mHc%lkp@intel.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <78c2cce6-19ae-302c-6e5a-3798f658c8e2@arm.com>
Date: Wed, 4 Sep 2019 16:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201909021437.rO6o0mHc%lkp@intel.com>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, kbuild-all@01.org, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
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

On 02/09/2019 08:06, kbuild test robot wrote:
> Hi Steven,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190830]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Steven-Price/arm64-Stolen-time-support/20190901-185152
> config: i386-randconfig-a002-201935 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/kvm/arm_hypercalls.h:7:0,
>                     from <command-line>:0:
>>> arch/x86/include/asm/kvm_emulate.h:349:22: error: 'NR_VCPU_REGS' undeclared here (not in a function)
>      unsigned long _regs[NR_VCPU_REGS];
>                          ^~~~~~~~~~~~

This is because x86's asm/kvm_emulate.h can't be included by itself (and
doesn't even exist on other architectures). This new header file doesn't
make sense to include on x86, so I'll squash in the following to prevent
building the header file except on arm/arm64.

Steve

----8<----
diff --git a/include/Kbuild b/include/Kbuild
index c38f0d46b267..f775ea28716e 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -67,6 +67,8 @@ header-test-			+= keys/big_key-type.h
 header-test-			+= keys/request_key_auth-type.h
 header-test-			+= keys/trusted.h
 header-test-			+= kvm/arm_arch_timer.h
+header-test-$(CONFIG_ARM)	+= kvm/arm_hypercalls.h
+header-test-$(CONFIG_ARM64)	+= kvm/arm_hypercalls.h
 header-test-			+= kvm/arm_pmu.h
 header-test-$(CONFIG_ARM)	+= kvm/arm_psci.h
 header-test-$(CONFIG_ARM64)	+= kvm/arm_psci.h
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
