Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1817FBC8
	for <lists+kvmarm@lfdr.de>; Tue, 10 Mar 2020 14:17:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 592494A591;
	Tue, 10 Mar 2020 09:17:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8WSj3cNp3ztI; Tue, 10 Mar 2020 09:17:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 216904A4F7;
	Tue, 10 Mar 2020 09:16:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F181C4A4AA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 09:16:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NQv0xt-e11L1 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Mar 2020 09:16:57 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 06D9640A52
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 09:16:56 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9503E24693;
 Tue, 10 Mar 2020 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583846215;
 bh=CiF2e4Gu3MUdh7Lg3zur4QzwVBU4lRXnHY3VzJVyY/4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Dyd17xpVF0JxkmyH3agz6PA0jQ9JY+cKzy37NP2xJREQyR1k4eYVBwOMm3QBwZafZ
 78doEykwC9a3jiy++aeUHd2sjMmBr52uxv6lUDfQzWrsO5rzavgL7Be86zUEPOKaZw
 rwwyMfDKk9vYKGWvUHcwjyAXo+h3EcV1GpDqMlbg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jBekf-00Bb9d-VK; Tue, 10 Mar 2020 13:16:54 +0000
MIME-Version: 1.0
Date: Tue, 10 Mar 2020 13:16:53 +0000
From: Marc Zyngier <maz@kernel.org>
To: zhukeqian <zhukeqian1@huawei.com>
Subject: Re: [RFC] KVM: arm64: support enabling dirty log graually in small
 chunks
In-Reply-To: <64925c8b-af3d-beb5-bc9b-66ef1e47f92d@huawei.com>
References: <20200309085727.1106-1-zhukeqian1@huawei.com>
 <4b85699ec1d354cc73f5302560231f86@misterjones.org>
 <64925c8b-af3d-beb5-bc9b-66ef1e47f92d@huawei.com>
Message-ID: <a642a79ea9190542a9098e4c9dc5a9f2@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhukeqian1@huawei.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jianjay.zhou@huawei.com,
 sean.j.christopherson@intel.com, pbonzini@redhat.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Jay Zhou <jianjay.zhou@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-03-10 08:26, zhukeqian wrote:
> Hi Marc,
> 
> On 2020/3/9 19:45, Marc Zyngier wrote:
>> Kegian,

[...]

>> Is there a userspace counterpart to it?
>> 
> As this KVM/x86 related changes have not been merged to mainline
> kernel, some little modification is needed on mainline Qemu.

Could you please point me to these changes?

> As I tested this patch on a 128GB RAM Linux VM with no huge pages, the
> time of enabling dirty log will decrease obviously.

I'm not sure how realistic that is. Not having huge pages tends to lead
to pretty bad performance in general...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
