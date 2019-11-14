Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D10F9FCA33
	for <lists+kvmarm@lfdr.de>; Thu, 14 Nov 2019 16:47:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 65EE24AF05;
	Thu, 14 Nov 2019 10:47:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oKqR3M9W7VEZ; Thu, 14 Nov 2019 10:47:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CE7D4AEFB;
	Thu, 14 Nov 2019 10:47:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BDB84ACE8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 10:47:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3cP37yldjBYd for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Nov 2019 10:47:47 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A31F4ACB9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 10:47:47 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3F05328;
 Thu, 14 Nov 2019 07:47:46 -0800 (PST)
Received: from [10.1.196.63] (e123195-lin.cambridge.arm.com [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9842A3F52E;
 Thu, 14 Nov 2019 07:47:45 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH 09/17] arm: gic: Add test for flipping
 GICD_CTLR.DS
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191108144240.204202-1-andre.przywara@arm.com>
 <20191108144240.204202-10-andre.przywara@arm.com>
 <2e14ccd4-89f4-aa90-cc58-bebf0e2eeede@arm.com>
 <7ca57a0c-3934-1778-e3f9-a3eee0658002@arm.com>
 <20191114141745.32d3b89c@donnerap.cambridge.arm.com>
 <90cdc695-f761-26bd-d2a7-f8655ce04463@arm.com>
 <187393bb-a32d-092d-d0ea-44c58a54d1de@arm.com>
 <CAFEAcA_kcQwrnJxtCynX9+hMEvnFN0yBnim_Kn-uut5P4fshew@mail.gmail.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <241e3df3-e3e3-14a0-3fbe-5398a1bf9d00@arm.com>
Date: Thu, 14 Nov 2019 15:47:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_kcQwrnJxtCynX9+hMEvnFN0yBnim_Kn-uut5P4fshew@mail.gmail.com>
Content-Language: en-US
Cc: kvm-devel <kvm@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
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

On 11/14/19 3:27 PM, Peter Maydell wrote:
> On Thu, 14 Nov 2019 at 15:21, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>> TCG emulates a GIC with a single security state for me:
>>
>> /usr/bin/qemu-system-aarch64 -nodefaults -machine virt,gic-version=3,accel=tcg
>> -cpu cortex-a57 -device virtio-serial-device -device virtconsole,chardev=ctd
>> -chardev testdev,id=ctd -device pci-testdev -display none -serial stdio -kernel
>> arm/gic.flat -append irq
> The virt board doesn't do EL3 by default, but if you add -machine secure=true
> to your command line then it it should emulate it, including a
> trustzone-aware GIC.
>
> thanks
> -- PMM

Indeed, and that made the test fail because apparently qemu implements it as
RAZ/WI (which is allowed by the architecture). Thank you for the suggestion!

Thanks,
Alex


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
