Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9D262AC7
	for <lists+kvmarm@lfdr.de>; Wed,  9 Sep 2020 10:46:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 590D64B581;
	Wed,  9 Sep 2020 04:46:25 -0400 (EDT)
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
	with ESMTP id piqk7nGl6H2M; Wed,  9 Sep 2020 04:46:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B7A74B54B;
	Wed,  9 Sep 2020 04:46:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 16A5B4B41D
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Sep 2020 04:44:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fg2t29RebKlm for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Sep 2020 04:43:56 -0400 (EDT)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 78BCB4B3F1
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Sep 2020 04:43:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1599641037; x=1631177037;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=lHG13q4oh+i/9HDrkU/99B0v9sg5oHwRUwfGLVJvGbg=;
 b=NGnnfN7rN9MwvyMHoaDjrGEPr3dNsO+S6WB5Q1SlJFPY9VZj+hsHV0tX
 DqGSRJT1S1HMphxLceG3c7tn/yH8pvo0XZfbVkSkuwFB/trdm5iJFce6x
 Iccw4fJ1PsJhuXUhNLye5tKBQuzwFBp36FpHAoJQNgcvp3ZW6zygaFuLI A=;
X-IronPort-AV: E=Sophos;i="5.76,409,1592870400"; d="scan'208";a="74720871"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 09 Sep 2020 08:43:51 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS
 id 67F78A1836; Wed,  9 Sep 2020 08:43:50 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 9 Sep 2020 08:43:49 +0000
Received: from Alexanders-MacBook-Air.local (10.43.162.55) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 9 Sep 2020 08:43:46 +0000
Subject: Re: [PATCH v2] KVM: arm64: Allow to limit number of PMU counters
To: Andrew Jones <drjones@redhat.com>
References: <20200908205730.23898-1-graf@amazon.com>
 <20200909062534.zsqadaeewfeqsgsj@kamzik.brq.redhat.com>
From: Alexander Graf <graf@amazon.com>
Message-ID: <fcb9ccab-2118-af76-3109-4d491d888c7c@amazon.com>
Date: Wed, 9 Sep 2020 10:43:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200909062534.zsqadaeewfeqsgsj@kamzik.brq.redhat.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.55]
X-ClientProxiedBy: EX13D17UWC003.ant.amazon.com (10.43.162.206) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
X-Mailman-Approved-At: Wed, 09 Sep 2020 04:46:23 -0400
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
 kvmarm@lists.cs.columbia.edu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hey Drew!

On 09.09.20 08:25, Andrew Jones wrote:
> 
> On Tue, Sep 08, 2020 at 10:57:30PM +0200, Alexander Graf wrote:
>> We currently pass through the number of PMU counters that we have available
>> in hardware to guests. So if my host supports 10 concurrently active PMU
>> counters, my guest will be able to spawn 10 counters as well.
>>
>> This is undesireable if we also want to use the PMU on the host for
>> monitoring. In that case, we want to split the PMU between guest and
>> host.
>>
>> To help that case, let's add a PMU attr that allows us to limit the number
>> of PMU counters that we expose. With this patch in place, user space can
>> keep some counters free for host use.
> 
> Hi Alex,
> 
> Is there any reason to use the device API instead of just giving the user
> control over the necessary PMCR_EL0 bits through set/get-one-reg?

I mostly used the attr interface because I was in that particular mental 
mode after looking at the filtering bits :).

Today, the PMCR_EL0 register gets reset implicitly on every vcpu reset 
call. How would we persist the counter field across resets? Would we in 
the first place?

I'm slightly hazy how the ONE_REG API would look like here. Do you have 
recommendations?


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
