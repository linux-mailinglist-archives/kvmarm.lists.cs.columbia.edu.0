Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5B418F7E
	for <lists+kvmarm@lfdr.de>; Mon, 27 Sep 2021 08:54:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D59AC4B108;
	Mon, 27 Sep 2021 02:54:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@ibm.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7UYPld915XdT; Mon, 27 Sep 2021 02:54:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83D434B091;
	Mon, 27 Sep 2021 02:54:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A59664083E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Sep 2021 02:54:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lhlOJ2o0B7X5 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Sep 2021 02:54:50 -0400 (EDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 80A884048B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Sep 2021 02:54:50 -0400 (EDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18R2iku9027135; 
 Mon, 27 Sep 2021 02:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Jiq7gvoz3pplZUufR4kw3kQJZqSIDso0Eiiy9V37bEM=;
 b=VkEysG81hdqNPtmizeFNiqRMUtPhpslhfpZ7XwSUR8TlVvZjPFw874jOUgvVqAYlwML5
 Mh7/4PtNOTYIQKIA8kffQU9p/V0+uh+5TVPm9vXf0HDixLV9M6pu/OYQ7j3oCwwbpxj+
 gwORYMdTe9bIkRKFPZ6iLlFxilDinOZ5xwWQPgGN7P0cOExfLptyyURr6ECjcHhf11XD
 i8bBDFJZfWoEKg2yZ1Ib7b/PNfBkxUYItXG8QZa0yAFH2xLMFEiHmoj/UeIYRr3v/jXb
 InNrJk+G4WUP879bfIvCaL6Vlr/NBz9+lbY10Ec7osQxukaZzImGV1JXdjWKFAweRfv1 pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bagv7v60d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Sep 2021 02:54:43 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18R60135023974;
 Mon, 27 Sep 2021 02:54:42 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bagv7v5yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Sep 2021 02:54:42 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18R6l9YC022190;
 Mon, 27 Sep 2021 06:54:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma05fra.de.ibm.com with ESMTP id 3b9ud8rnj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Sep 2021 06:54:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 18R6sZUt52101612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Sep 2021 06:54:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 648AD52050;
 Mon, 27 Sep 2021 06:54:35 +0000 (GMT)
Received: from li-43c5434c-23b8-11b2-a85c-c4958fb47a68.ibm.com (unknown
 [9.171.4.236])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CF8525205F;
 Mon, 27 Sep 2021 06:54:33 +0000 (GMT)
Subject: Re: [PATCH 01/14] KVM: s390: Ensure kvm_arch_no_poll() is read once
 when blocking vCPU
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, Janosch Frank <frankja@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20210925005528.1145584-1-seanjc@google.com>
 <20210925005528.1145584-2-seanjc@google.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <01fa2462-6652-7206-5ef3-bacb3452b4c8@de.ibm.com>
Date: Mon, 27 Sep 2021 08:54:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210925005528.1145584-2-seanjc@google.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LRqB5f6S9hbk17-RqSL7Lr4MRuKyWqHw
X-Proofpoint-ORIG-GUID: EuLGaHU57XrzZa8qPJevhWzEyIkwBjOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_01,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270042
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, David Matlack <dmatlack@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
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



Am 25.09.21 um 02:55 schrieb Sean Christopherson:
> Wrap s390's halt_poll_max_steal with READ_ONCE and snapshot the result of
> kvm_arch_no_poll() in kvm_vcpu_block() to avoid a mostly-theoretical,
> largely benign bug on s390 where the result of kvm_arch_no_poll() could
> change due to userspace modifying halt_poll_max_steal while the vCPU is
> blocking.  The bug is largely benign as it will either cause KVM to skip
> updating halt-polling times (no_poll toggles false=>true) or to update
> halt-polling times with a slightly flawed block_ns.
> 
> Note, READ_ONCE is unnecessary in the current code, add it in case the
> arch hook is ever inlined, and to provide a hint that userspace can
> change the param at will.
> 
> Fixes: 8b905d28ee17 ("KVM: s390: provide kvm_arch_no_poll function")
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>   arch/s390/kvm/kvm-s390.c | 2 +-
>   virt/kvm/kvm_main.c      | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 6a6dd5e1daf6..7cabe6778b1b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3446,7 +3446,7 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>   {
>   	/* do not poll with more than halt_poll_max_steal percent of steal time */
>   	if (S390_lowcore.avg_steal_timer * 100 / (TICK_USEC << 12) >=
> -	    halt_poll_max_steal) {
> +	    READ_ONCE(halt_poll_max_steal)) {
>   		vcpu->stat.halt_no_poll_steal++;
>   		return true;
>   	}
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 191dac6b1bed..768a4cbb26a6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3213,6 +3213,7 @@ update_halt_poll_stats(struct kvm_vcpu *vcpu, u64 poll_ns, bool waited)
>    */
>   void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>   {
> +	bool halt_poll_allowed = !kvm_arch_no_poll(vcpu);
>   	ktime_t start, cur, poll_end;
>   	bool waited = false;
>   	u64 block_ns;
> @@ -3220,7 +3221,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>   	kvm_arch_vcpu_blocking(vcpu);
>   
>   	start = cur = poll_end = ktime_get();
> -	if (vcpu->halt_poll_ns && !kvm_arch_no_poll(vcpu)) {
> +	if (vcpu->halt_poll_ns && halt_poll_allowed) {
>   		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
>   
>   		++vcpu->stat.generic.halt_attempted_poll;
> @@ -3275,7 +3276,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>   	update_halt_poll_stats(
>   		vcpu, ktime_to_ns(ktime_sub(poll_end, start)), waited);
>   
> -	if (!kvm_arch_no_poll(vcpu)) {
> +	if (halt_poll_allowed) {
>   		if (!vcpu_valid_wakeup(vcpu)) {
>   			shrink_halt_poll_ns(vcpu);
>   		} else if (vcpu->kvm->max_halt_poll_ns) {
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
