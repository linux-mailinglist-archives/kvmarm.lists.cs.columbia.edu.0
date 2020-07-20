Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A111E2262A5
	for <lists+kvmarm@lfdr.de>; Mon, 20 Jul 2020 16:56:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 36F214B1BA;
	Mon, 20 Jul 2020 10:56:57 -0400 (EDT)
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
	with ESMTP id ABS-icAVAdfm; Mon, 20 Jul 2020 10:56:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 100F54B198;
	Mon, 20 Jul 2020 10:56:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E932C4B108
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Jul 2020 10:56:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V6HD0jtIw7iK for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Jul 2020 10:56:53 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C66D54B0C9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Jul 2020 10:56:53 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A87EC22B4E;
 Mon, 20 Jul 2020 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595257012;
 bh=lMz4qhBNDbC5WHY1eOEyUsKYsYkeqLEPAcKmFb0MdS4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E4OcyNII4eRNd+xlEjq1vDV3g2ejs60+hD9nbJnOz/DNZ9+D2NoGuTfa+Njn231qa
 nojxsx7MmaG+wkMvWKtHwY7yjO9Q1FJOoP3JLNZoIgu8I7Jj+0VMj/9MYBvOlxOdqc
 bH1QX29GEmB5Iv+KwgzHgyvUv6g5aa9A9ZYb/J1w=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jxXDn-00DLCV-91; Mon, 20 Jul 2020 15:56:51 +0100
MIME-Version: 1.0
Date: Mon, 20 Jul 2020 15:56:51 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH 07/37] KVM: arm64: Separate SError detection from VAXorcism
In-Reply-To: <20200720141349.GA2179496@google.com>
References: <20200715184438.1390996-1-ascull@google.com>
 <20200715184438.1390996-8-ascull@google.com> <87a6zxxknl.wl-maz@kernel.org>
 <20200720141349.GA2179496@google.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <500058465906ab72122127cf745568c6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ascull@google.com, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On 2020-07-20 15:13, Andrew Scull wrote:
> On Sat, Jul 18, 2020 at 10:00:30AM +0100, Marc Zyngier wrote:
>> Hi Andrew,
>> 
>> On Wed, 15 Jul 2020 19:44:08 +0100,
>> Andrew Scull <ascull@google.com> wrote:
>> >
>> > When exiting a guest, just check whether there is an SError pending and
>> > set the bit in the exit code. The fixup then initiates the ceremony
>> > should it be required.
>> >
>> > The separation allows for easier choices to be made as to whether the
>> > demonic consultation should proceed.
>> 
>> Such as?
> 
> It's used in the next patch to keep host SErrors pending and left for
> the host to handle when reentering the host vcpu. IIUC, this matches 
> the
> previous behaviour since hyp would mask SErrors.
> 
> We wanted to avoid the need to convert host SErrors into virtual ones
> and I opted for this approach to keep as much of the logic/policy as
> possible in C.

Right. That's the kind of information you should put in your commit
message, as it makes your intent much clearer.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
