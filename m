Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 14D842A849D
	for <lists+kvmarm@lfdr.de>; Thu,  5 Nov 2020 18:16:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8009A4B778;
	Thu,  5 Nov 2020 12:16:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6gVs5SW5WmCF; Thu,  5 Nov 2020 12:16:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1143A4B79C;
	Thu,  5 Nov 2020 12:16:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C64A4B678
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Nov 2020 12:16:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 36SSJjVuwkJI for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Nov 2020 12:16:18 -0500 (EST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5D7954B4FA
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Nov 2020 12:16:18 -0500 (EST)
IronPort-SDR: 3TtkoKDugWE8ahej+XxNpW1y8iSWjZr/S2KSiz5sQnxnshu0Dt0wrz+EFdqMtrITYU6JoWhgPn
 2t6HFA55Cg9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="233588870"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
 d="gz'50?scan'50,208,50";a="233588870"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 09:16:16 -0800
IronPort-SDR: iPxvwf38QWR0MSWhQQQkpv9oQGHvK02SRKy6jV+2yWfqOIB23DVO1/e6G/ETOBJoUtMnr0uB2O
 XU0SgFQqN+eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
 d="gz'50?scan'50,208,50";a="364414624"
Received: from lkp-server01.sh.intel.com (HELO a340e641b702) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 05 Nov 2020 09:16:12 -0800
Received: from kbuild by a340e641b702 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kairs-00002X-8p; Thu, 05 Nov 2020 17:16:12 +0000
Date: Fri, 6 Nov 2020 01:15:50 +0800
From: kernel test robot <lkp@intel.com>
To: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 3/5] ARM: implement support for SMCCC TRNG entropy
 source
Message-ID: <202011060138.cwmseHpK-lkp@intel.com>
References: <20201105125656.25259-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20201105125656.25259-4-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andre,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.10-rc2 next-20201105]
[cannot apply to arm64/for-next/core kvmarm/next arm-perf/for-next/perf]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andre-Przywara/ARM-arm64-Add-SMCCC-TRNG-entropy-service/20201105-205934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4ef8451b332662d004df269d4cdeb7d9f31419b5
config: arm-tango4_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1f0c18ec0b7aa0a67d7cdea2b1beb5e7b38c5f4b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andre-Przywara/ARM-arm64-Add-SMCCC-TRNG-entropy-service/20201105-205934
        git checkout 1f0c18ec0b7aa0a67d7cdea2b1beb5e7b38c5f4b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/char/random.o: in function `arch_get_random_seed_long':
>> random.c:(.text+0x134): undefined reference to `smccc_trng_available'
>> arm-linux-gnueabi-ld: random.c:(.text+0x138): undefined reference to `smccc_trng_available'
>> arm-linux-gnueabi-ld: random.c:(.text+0x15c): undefined reference to `arm_smccc_1_1_get_conduit'
   arm-linux-gnueabi-ld: drivers/char/random.o: in function `crng_reseed.constprop.0':
   random.c:(.text+0xe74): undefined reference to `smccc_trng_available'
   arm-linux-gnueabi-ld: random.c:(.text+0xe7c): undefined reference to `smccc_trng_available'
   arm-linux-gnueabi-ld: random.c:(.text+0xedc): undefined reference to `arm_smccc_1_1_get_conduit'
   arm-linux-gnueabi-ld: drivers/char/random.o: in function `add_interrupt_randomness':
   random.c:(.text+0x1f00): undefined reference to `smccc_trng_available'
   arm-linux-gnueabi-ld: random.c:(.text+0x1f04): undefined reference to `smccc_trng_available'
   arm-linux-gnueabi-ld: random.c:(.text+0x1f4c): undefined reference to `arm_smccc_1_1_get_conduit'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7Htwh05RASXk5sg7PfaMf/Sp/f8ADDdDt8oVAQA=

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--VbJkn9YxBvnuCH5J--
