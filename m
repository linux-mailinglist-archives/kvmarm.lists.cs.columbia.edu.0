Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A4105B4EEC
	for <lists+kvmarm@lfdr.de>; Tue, 17 Sep 2019 15:14:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 996CC4A685;
	Tue, 17 Sep 2019 09:14:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2M5Tio+waL98; Tue, 17 Sep 2019 09:14:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1FD534A689;
	Tue, 17 Sep 2019 09:14:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 467B84A676
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Sep 2019 09:14:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZTD0jzXqxqfr for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Sep 2019 09:14:23 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EE4494A5C4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Sep 2019 09:14:22 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6957F28;
 Tue, 17 Sep 2019 06:14:22 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B6A843F575; Tue, 17 Sep 2019 06:14:21 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: vgic-v4: Move the GICv4 residency flow to be
 driven by vcpu_load/put
To: Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20190903155747.219802-1-maz@kernel.org>
 <5ab75fec-6014-e3b4-92a3-63d5015814c1@huawei.com>
 <07ddb304-9a7a-64a3-386a-96eea4516346@kernel.org>
 <dcc5a10b-c9ca-f833-4a60-e5d3726fa0b9@huawei.com>
 <3b2d4a15-5658-f50f-0214-1da708cd4923@huawei.com>
From: Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <c068036a-e9e2-0cb1-d1b5-9cf6d53e963f@kernel.org>
Date: Tue, 17 Sep 2019 14:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3b2d4a15-5658-f50f-0214-1da708cd4923@huawei.com>
Content-Language: en-US
Cc: Andre Przywara <Andre.Przywara@arm.com>
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

On 17/09/2019 11:17, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2019/9/17 17:31, Zenghui Yu wrote:
>>
>> But this time I got the following WARNING:
> 
> Please ignore it. I think this is mostly caused by my local buggy
> patch... Sorry for the noise.

Right. I couldn't quite figure out how this could happen with the
current state of the code...

	M.
-- 
Jazz is not dead, it just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
