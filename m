Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A661843CF00
	for <lists+kvmarm@lfdr.de>; Wed, 27 Oct 2021 18:50:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 56CF44B1AB;
	Wed, 27 Oct 2021 12:50:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@quicinc.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VakdVZj4lfC3; Wed, 27 Oct 2021 12:50:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AF604B1CF;
	Wed, 27 Oct 2021 12:49:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D2034B159
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Oct 2021 11:13:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DLmESEfiPQFG for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Oct 2021 11:13:58 -0400 (EDT)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 12D524B153
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Oct 2021 11:13:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1635347638; x=1666883638;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Ai+eDdXkfnWg+d1nZS2x7qtRIy6LUrKbeHhn2zVblMw=;
 b=tlyvuo0Ok8f2UNGV36WNJD695rcjYTSBPGcQ1gfiF8u5KLxJmlCE5mEf
 TxwxNAlwKGpSknYgdOGONg5LCCZ2hTsXa0gzDc5irwhmDiLcBoHEEjqJF
 c4nS1JZqBqi5yGcltUVlj0bDnHTc9WzJYaq6NNrTx3A8AHR+m/5CRmbhx 0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 08:13:56 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 08:13:56 -0700
Received: from [10.110.114.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Wed, 27 Oct 2021
 08:13:55 -0700
Subject: Re: [PATCH] KVM: arm64: Avoid shadowing a previous local
To: Marc Zyngier <maz@kernel.org>
References: <20211027024212.64842-1-quic_qiancai@quicinc.com>
 <da6be00d39c37ad26bfad9e75e814cb1@kernel.org>
From: Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <247f9c62-3031-24d4-eb58-be6a4d5a364e@quicinc.com>
Date: Wed, 27 Oct 2021 11:13:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <da6be00d39c37ad26bfad9e75e814cb1@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Mailman-Approved-At: Wed, 27 Oct 2021 12:49:56 -0400
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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



On 10/27/21 3:34 AM, Marc Zyngier wrote:
> I don't think this makes much sense. This is bound to eventually clash
> with another variable, and you're back to square one.

Yes, perhaps. We don't have a namespace feature in C. Thanks for taking
a look, Marc.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
