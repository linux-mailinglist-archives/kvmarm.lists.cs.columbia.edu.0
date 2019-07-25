Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60C74FCA
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jul 2019 15:41:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D7D444A5EB;
	Thu, 25 Jul 2019 09:41:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -3.291
X-Spam-Level: 
X-Spam-Status: No, score=-3.291 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4UseQlKJ4QCx; Thu, 25 Jul 2019 09:41:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C02C24A5C3;
	Thu, 25 Jul 2019 09:41:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E606B4A59F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 09:41:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h4R74Ydj-0aX for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jul 2019 09:41:35 -0400 (EDT)
Received: from smtp-fw-4101.amazon.com (smtp-fw-4101.amazon.com [72.21.198.25])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E7EE94A593
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 09:41:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1564062095; x=1595598095;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=QUEc3pPPB/SdkJAuqWPzwUgUDlbaN8uH500rEis8xzk=;
 b=OCMw7fL8mzJCANc7XlskZViafjwCHfLSZh2gg6Abx1PE3SQPUHsHnGAC
 QvogPmZPH1bQoz0recqRqKIU+/qTLsS+j09XWQ3XAwQcJWytqPmrT/s25
 xYBYQrhFULpwGhT+qr5qjIaM9fiDHTWs9v2BqP/NkEenGxGrSyODPBGuI M=;
X-IronPort-AV: E=Sophos;i="5.64,306,1559520000"; d="scan'208";a="776218294"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 25 Jul 2019 13:41:34 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS
 id E917CA2F62; Thu, 25 Jul 2019 13:41:32 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 25 Jul 2019 13:41:32 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.137) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 25 Jul 2019 13:41:30 +0000
Subject: Re: [PATCH kvm-unit-tests v4] arm: Add PL031 test
To: Andrew Jones <drjones@redhat.com>
References: <20190725130949.27436-1-graf@amazon.com>
 <20190725132506.2m4gkrsfcl422ztz@kamzik.brq.redhat.com>
From: Alexander Graf <graf@amazon.com>
Message-ID: <120e8ada-306f-9373-2f26-9584d604a44b@amazon.com>
Date: Thu, 25 Jul 2019 15:41:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725132506.2m4gkrsfcl422ztz@kamzik.brq.redhat.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.137]
X-ClientProxiedBy: EX13D28UWB002.ant.amazon.com (10.43.161.140) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Precedence: Bulk
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu



On 25.07.19 15:25, Andrew Jones wrote:
> On Thu, Jul 25, 2019 at 03:09:49PM +0200, Alexander Graf wrote:
>> This patch adds a unit test for the PL031 RTC that is used in the virt machine.
>> It just pokes basic functionality. I've mostly written it to familiarize myself
>> with the device, but I suppose having the test around does not hurt, as it also
>> exercises the GIC SPI interrupt path.
>>
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>>
>>    - Use FDT to find base, irq and existence
>>    - Put isb after timer read
>>    - Use dist_base for gicv3
>>
>> v2 -> v3
>>
>>    - Enable compilation on 32bit ARM target
>>    - Use ioremap
>>
>> v3 -> v4:
>>
>>    - Use dt_pbus_translate_node()
>>    - Make irq_triggered volatile
>> ---
>>   arm/Makefile.common |   1 +
>>   arm/pl031.c         | 260 ++++++++++++++++++++++++++++++++++++++++++++
>>   lib/arm/asm/gic.h   |   1 +
>>   3 files changed, 262 insertions(+)
>>   create mode 100644 arm/pl031.c
> 
> Thanks for the new version. I have a new nit (below), but my r-b stands
> with or without making another change.
> 
> [...]
> 
>> +static int rtc_fdt_init(void)
>> +{
>> +	const struct fdt_property *prop;
>> +	const void *fdt = dt_fdt();
>> +	struct dt_pbus_reg base;
>> +	int node, len;
>> +	u32 *data;
>> +
>> +	node = fdt_node_offset_by_compatible(fdt, -1, "arm,pl031");
>> +	if (node < 0)
>> +		return -1;
>> +
>> +	prop = fdt_get_property(fdt, node, "interrupts", &len);
>> +	assert(prop && len == (3 * sizeof(u32)));
>> +	data = (u32 *)prop->data;
>> +	assert(data[0] == 0); /* SPI */
>> +	pl031_irq = SPI(fdt32_to_cpu(data[1]));
>> +
>> +	assert(!dt_pbus_translate_node(node, 0, &base));
> 
> We prefer to do something like
> 
>   ret = dt_pbus_translate_node(node, 0, &base);
>   assert(!ret);
> 
> than the above, just in case we ever compiled with assert() defined as a
> no-op. But the probability of doing that is pretty close to zero.

Yeah, but before someone wastes an hour of debugging on this later, 
let's fix it right away. Thanks for catching it! :)


Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
