Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C16505A9E86
	for <lists+kvmarm@lfdr.de>; Thu,  1 Sep 2022 19:59:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A3D8C49ED8;
	Thu,  1 Sep 2022 13:59:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UiezVysIh1E3; Thu,  1 Sep 2022 13:59:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 214FB4B106;
	Thu,  1 Sep 2022 13:59:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B29ED49F31
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Sep 2022 13:59:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MgQymnrDqgzo for <kvmarm@lists.cs.columbia.edu>;
 Thu,  1 Sep 2022 13:59:31 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4B1E549F14
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Sep 2022 13:59:31 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 329A6611C0;
 Thu,  1 Sep 2022 17:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED34C433C1;
 Thu,  1 Sep 2022 17:59:27 +0000 (UTC)
Date: Thu, 1 Sep 2022 18:59:23 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/7] mm: Add PG_arch_3 page flag
Message-ID: <YxDy+zFasbAP7Yrq@arm.com>
References: <20220810193033.1090251-4-pcc@google.com>
 <202208111500.62e0Bl2l-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202208111500.62e0Bl2l-lkp@intel.com>
Cc: kbuild-all@lists.01.org, kvm@vger.kernel.org,
 Peter Collingbourne <pcc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Steven Price <steven.price@arm.com>, Evgenii Stepanov <eugenis@google.com>,
 Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

On Thu, Aug 11, 2022 at 03:16:08PM +0800, kernel test robot wrote:
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on linus/master next-20220811]
> [cannot apply to kvmarm/next arm/for-next soc/for-next xilinx-xlnx/master v5.19]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Collingbourne/KVM-arm64-permit-MAP_SHARED-mappings-with-MTE-enabled/20220811-033310
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20220811/202208111500.62e0Bl2l-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/1a400517d8428df0ec9f86f8d303b2227ee9702f
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Peter-Collingbourne/KVM-arm64-permit-MAP_SHARED-mappings-with-MTE-enabled/20220811-033310
>         git checkout 1a400517d8428df0ec9f86f8d303b2227ee9702f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/memory.c:92:2: warning: #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid. [-Wcpp]
>       92 | #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
>          |  ^~~~~~~
> 
> 
> vim +92 mm/memory.c
> 
> 42b7772812d15b Jan Beulich    2008-07-23  90  
> af27d9403f5b80 Arnd Bergmann  2018-02-16  91  #if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
> 90572890d20252 Peter Zijlstra 2013-10-07 @92  #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
> 75980e97daccfc Peter Zijlstra 2013-02-22  93  #endif
> 75980e97daccfc Peter Zijlstra 2013-02-22  94  

It looks like ith CONFIG_NUMA_BALANCING=y on loongarch we run out of
spare bits in page->flags to fit last_cpupid. The reason we don't see it
on arm64 is that we select SPARSEMEM_VMEMMAP and SECTIONS_WIDTH becomes
0. On loongarch SECTIONS_WIDTH takes 19 bits (48 - 29) in page->flags.

I think instead of always defining PG_arch_{2,3} if CONFIG_64BIT, we
could add a CONFIG_ARCH_WANTS_PG_ARCH_23 option and only select it on
arm64 for the time being.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
