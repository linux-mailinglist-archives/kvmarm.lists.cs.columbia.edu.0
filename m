Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7910A406788
	for <lists+kvmarm@lfdr.de>; Fri, 10 Sep 2021 09:12:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF7C94B16E;
	Fri, 10 Sep 2021 03:12:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id meSRPfCDPwJa; Fri, 10 Sep 2021 03:12:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AB7D4B176;
	Fri, 10 Sep 2021 03:12:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 089674B15C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Sep 2021 03:12:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AbsGG8EubRHK for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Sep 2021 03:12:42 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 35DA54B130
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Sep 2021 03:12:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631257962;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ISP21JdBfrzKPln3oVCGs9+0XULEd4mYwEeP7w0w2c=;
 b=ZvQt8GS/LeVFnBWsLvGmuEbi52iG41Nntsh2dQ/1g+lfeI+WCcuJESAt7zCjuHAqDOQIkm
 t1WJlg1NIn2QKc7X2wOePcKmEBQGleJduST2+WlmW3sWL07VoKrun2WdR1SwCJmg0HBpQT
 i2hkffe41WovpPgIiMDRtl2SnKC36WQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-yj_TcEVQNPm0SXY90Ne3gQ-1; Fri, 10 Sep 2021 03:12:41 -0400
X-MC-Unique: yj_TcEVQNPm0SXY90Ne3gQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 z2-20020a5d4c82000000b0015b140e0562so168006wrs.7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Sep 2021 00:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=4ISP21JdBfrzKPln3oVCGs9+0XULEd4mYwEeP7w0w2c=;
 b=YOL6iaAKZiR9YkQispAv1DifsR7ajJiBD4HSARMYlwV7o/BtNY88YbL6lGIAk5nP6R
 o2W9Fgp1VXyQoK9QhqYiktqSwtYMc/Kz0L3mza7U9nLxEhZYf+4ATwFpuyuhWruBLPr1
 V/lHQfhHcP1A5Np+xBOXhE00WSgQLzBk90TcFu/Sr4GWeDVkRdIJPD8AHVSIwEMAm85e
 rktzbTX8tAYBSJzOcYzUH8/eMnmddWHMR8WVOGtWqrHGQKgY/NId3Miovxwbb2jKx0L/
 k2lRFwz+no92GeDG7ksZrkWtRJV/tOrFQKc0fBej+GAFZgNCGxBzwG+Gbd5Q1/ppjmr5
 FYqA==
X-Gm-Message-State: AOAM531v4FwwY7Q752rn/PCQu9rXQTMSTYMW9XfXbKUJOh5DC766XGmf
 GUdNgxRZA3qnh4ooHyA9VTugKRcu2gVFSidd/wEea5a9TAlyIR0SCgETiGJ7yhu9WYopX/o8Qmu
 8Rj01uAiRQPChdvh/w9tho/5K
X-Received: by 2002:a5d:538e:: with SMTP id d14mr7966158wrv.192.1631257959757; 
 Fri, 10 Sep 2021 00:12:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGBvwyOl/M6aG9dvJhp94O8ADjwpjuDHrwESDcghO2xGm9zlU5kOqz87JrcqTkhEBPGLO1ng==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr7966109wrv.192.1631257959440; 
 Fri, 10 Sep 2021 00:12:39 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id u27sm4071795wru.2.2021.09.10.00.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Sep 2021 00:12:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: arm64: selftests: test for vgic redist above the
 VM IPA size
To: Ricardo Koller <ricarkol@google.com>
References: <20210908210320.1182303-1-ricarkol@google.com>
 <20210908210320.1182303-3-ricarkol@google.com>
 <83282104-ca04-c4f5-3570-c884a22ab667@redhat.com>
 <YTpQ4y37RhaQTJ3m@google.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <70787ee2-a393-8c1e-d8fc-aa85ff989c8c@redhat.com>
Date: Fri, 10 Sep 2021 09:12:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YTpQ4y37RhaQTJ3m@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, maz@kernel.org, shuah@kernel.org, pshier@google.com,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: eric.auger@redhat.com
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

Hi Ricardo,

On 9/9/21 8:22 PM, Ricardo Koller wrote:
> On Thu, Sep 09, 2021 at 03:54:31PM +0200, Eric Auger wrote:
>> Hi Ricardo,
>>
>> On 9/8/21 11:03 PM, Ricardo Koller wrote:
>>> This test attempts (and fails) to set a redistributor region using the
>>> legacy KVM_VGIC_V3_ADDR_TYPE_REDIST that's partially above the
>>> VM-specified IPA size.
>>>
>>> Signed-off-by: Ricardo Koller <ricarkol@google.com>
>>> ---
>>>  .../testing/selftests/kvm/aarch64/vgic_init.c | 44 +++++++++++++++++++
>>>  1 file changed, 44 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
>>> index 623f31a14326..6dd7b5e91421 100644
>>> --- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
>>> +++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
>>> @@ -285,6 +285,49 @@ static void test_vcpus_then_vgic(void)
>>>  	vm_gic_destroy(&v);
>>>  }
>>>  
>>> +static void test_redist_above_vm_pa_bits(enum vm_guest_mode mode)
>>> +{
>>> +	struct vm_gic v;
>>> +	int ret, i;
>>> +	uint32_t vcpuids[] = { 1, 2, 3, 4, };
>>> +	int pa_bits = vm_guest_mode_params[mode].pa_bits;
>>> +	uint64_t addr, psize = 1ULL << pa_bits;
>>> +
>>> +	/* Add vcpu 1 */
>>> +	v.vm = vm_create_with_vcpus(mode, 1, DEFAULT_GUEST_PHY_PAGES,
>>> +				    0, 0, guest_code, vcpuids);
>>> +	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
>>> +
>>> +	/* Set space for half a redist, we have 1 vcpu, so this fails. */
>>> +	addr = psize - 0x10000;
>>> +	ret = _kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
>>> +				 KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
>>> +	TEST_ASSERT(ret && errno == EINVAL, "not enough space for one redist");
>>> +
>>> +	/* Set space for 3 redists, we have 1 vcpu, so this succeeds. */
>>> +	addr = psize - (3 * 2 * 0x10000);
>>> +	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
>>> +				 KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
>> I think you need to test both the old API (KVM_VGIC_V3_ADDR_TYPE_REDIST)
>> and the new one (KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION).
>>
>> Can't you integrate those new checks in existing tests,
>> subtest_redist_regions() and subtest_dist_rdist() which already tests
>> base addr beyond IPA limit (but not range end unfortunately). look for
>> E2BIG.
>>
> Had some issues adapting subtest_dist_rdist() as the IPA range check for
> ADDR_TYPE_REDIST is done at 1st vcpu run.  subtest_dist_rdist() is
> already used to set overlapping dist/redist regions, which is then
> checked to generate EINVAL on 1st vcpu run. If subtest_dist_rdist() is
> also used to set the redist region above phys_size, then there won't be
> a way of checking that the vcpu run fails because of both the overlap
> and IPA issue.  It was simpler and cleaner to just add a new function
> for the ADDR_TYPE_REDIST IPA range test.  Will adapt
OK I see, then effectively adding a new test was more straightforward.
> subtest_redist_regions() as the check for ADDR_TYPE_REDIST_REGION can be
> done when setting the regions.
OK
>
> Related Question:
>
> Both the KVM_VGIC_V3_ADDR_TYPE_REDIST and KVM_RUN currently return
> EINVAL with my proposed change (not E2BIG). I will change
> KVM_VGIC_V3_ADDR_TYPE_REDIST to fail with E2BIG, but will leave KVM_RUN
> failing with EINVAL.  Would you say that's the correct behavior?
This looks OK to me, as long as the KVM uapi doc documents is aligned.

Thanks

Eric
>
> Thanks,
> Ricardo
>
>> Thanks
>>
>> Eric
>>> +
>>> +	addr = 0x00000;
>>> +	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
>>> +			KVM_VGIC_V3_ADDR_TYPE_DIST, &addr, true);
>>> +
>>> +	/* Add three vcpus (2, 3, 4). */
>>> +	for (i = 1; i < 4; ++i)
>>> +		vm_vcpu_add_default(v.vm, vcpuids[i], guest_code);
>>> +
>>> +	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>>> +			  KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
>>> +
>>> +	/* Attempt to run a vcpu without enough redist space. */
>>> +	ret = run_vcpu(v.vm, vcpuids[3]);
>>> +	TEST_ASSERT(ret && errno == EINVAL,
>>> +			"redist base+size above IPA detected on 1st vcpu run");
>>> +
>>> +	vm_gic_destroy(&v);
>>> +}
>>> +
>>>  static void test_new_redist_regions(void)
>>>  {
>>>  	void *dummy = NULL;
>>> @@ -542,6 +585,7 @@ int main(int ac, char **av)
>>>  	test_kvm_device();
>>>  	test_vcpus_then_vgic();
>>>  	test_vgic_then_vcpus();
>>> +	test_redist_above_vm_pa_bits(VM_MODE_DEFAULT);
>>>  	test_new_redist_regions();
>>>  	test_typer_accesses();
>>>  	test_last_bit_redist_regions();

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
