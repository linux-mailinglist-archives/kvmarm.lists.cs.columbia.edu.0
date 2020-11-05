Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFE2A856F
	for <lists+kvmarm@lfdr.de>; Thu,  5 Nov 2020 18:57:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15FE84B7E6;
	Thu,  5 Nov 2020 12:57:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T91JxC+YMwrd; Thu,  5 Nov 2020 12:57:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A69424B7AF;
	Thu,  5 Nov 2020 12:57:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D8A44B719
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Nov 2020 12:57:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWJFc8jbJrQl for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Nov 2020 12:57:39 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C21C64B727
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Nov 2020 12:57:39 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4144114BF;
 Thu,  5 Nov 2020 09:57:39 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9142B3F719;
 Thu,  5 Nov 2020 09:57:37 -0800 (PST)
Subject: Re: [PATCH v2 3/5] ARM: implement support for SMCCC TRNG entropy
 source
To: kernel test robot <lkp@intel.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Russell King <linux@armlinux.org.uk>
References: <20201105125656.25259-4-andre.przywara@arm.com>
 <202011060104.RRRtFPOR-lkp@intel.com>
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <9b13b9c3-66a5-8dbb-868d-f826ae29a11a@arm.com>
Date: Thu, 5 Nov 2020 17:56:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <202011060104.RRRtFPOR-lkp@intel.com>
Content-Language: en-GB
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
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

On 05/11/2020 17:15, kernel test robot wrote:
> Hi Andre,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.10-rc2 next-20201105]
> [cannot apply to arm64/for-next/core kvmarm/next arm-perf/for-next/perf]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andre-Przywara/ARM-arm64-Add-SMCCC-TRNG-entropy-service/20201105-205934
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4ef8451b332662d004df269d4cdeb7d9f31419b5
> config: arm-randconfig-s031-20201105 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-76-gf680124b-dirty
>         # https://github.com/0day-ci/linux/commit/1f0c18ec0b7aa0a67d7cdea2b1beb5e7b38c5f4b
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andre-Przywara/ARM-arm64-Add-SMCCC-TRNG-entropy-service/20201105-205934
>         git checkout 1f0c18ec0b7aa0a67d7cdea2b1beb5e7b38c5f4b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: drivers/char/random.o: in function `arch_get_random_seed_long':
>>> arch/arm/include/asm/archrandom.h:48: undefined reference to `arm_smccc_1_1_get_conduit'
>>> arm-linux-gnueabi-ld: arch/arm/include/asm/archrandom.h:48: undefined reference to `smccc_trng_available'

Found it, we should use "depends on HAVE_ARM_SMCCC_DISCOVERY" instead of
HAVE_ARM_SMCCC, because only the former guarantees the build of smccc.c.
Will fix it in the next version, (given we keep this arch random part).

Thanks,
Andre

> 
> vim +48 arch/arm/include/asm/archrandom.h
> 
>     42	
>     43	static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>     44	{
>     45		struct arm_smccc_res res;
>     46	
>     47		if (smccc_trng_available) {
>   > 48			arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND32, 8 * sizeof(*v), &res);
>     49	
>     50			if (res.a0 != 0)
>     51				return false;
>     52	
>     53			*v = res.a3;
>     54			return true;
>     55		}
>     56	
>     57		return false;
>     58	}
>     59	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
