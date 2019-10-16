Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B0D37D8906
	for <lists+kvmarm@lfdr.de>; Wed, 16 Oct 2019 09:10:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D7CD74A97B;
	Wed, 16 Oct 2019 03:10:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GyVJ1SUaZrsQ; Wed, 16 Oct 2019 03:10:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D08BA4A9C4;
	Wed, 16 Oct 2019 03:10:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDBF64A97B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Oct 2019 03:10:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4F96eTQofcJT for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Oct 2019 03:10:12 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6E8D4A978
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Oct 2019 03:10:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571209812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48tYkDJe0SqGLusONClw8lIZHFqflqFfRXBr2ATDPpg=;
 b=NW4zMlUXY5AClFMVWh8ALxMVIzBvaQDqxmfW6pl9YX7zuBdxgBYhlB98H7spFcif+ayQzJ
 TjHWyVsdz1NXA4vCFrOIJJ0jwxp6QdmP3aq9y73D0YDMFwmBoiK/pDxfqpfPGUVOTlOqBN
 bLzcy7v4CBOqGr5o7rLe1lvevivMGJA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-dC4YZX4XOEGQ1T8VfZKL4w-1; Wed, 16 Oct 2019 03:10:10 -0400
Received: by mail-wr1-f69.google.com with SMTP id f3so11239441wrr.23
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Oct 2019 00:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8b7UpnoPmb5i1nQSpxNz3HRMIYoZAJY2z85wR9Og0Oo=;
 b=Q5JUmrN/VgKWPLeGQNFONECVKOh+450U6hh1E659ZAuu8sZcy1eO9DI5KYRHBaWrzE
 tGP7vTSco8UEhWesYy/xW6KhI/rr/6tpT/lKY0M6+hIS3zzXCs5HthmlxIyn5zd+5DDq
 Vlh4Iw4rd/HMw3guYXHEgirRL/jiXZ+6pGOMpfrwicn6KxVhKcZ7seW29d4c1Ei45OuB
 Nw6nE5Zzw8lVCAIdpWwb3q/6zWgnq6ELLP6IADjrMJhQhX+K4rFxyPvkMmKiuKhVlKH1
 vbBO3cueKrKDN1nT3BW9Tt8/8l5wDVvNE9VbRcxnN+ghQps4W7Uv+7qTlwA+osyKDwgu
 9ddg==
X-Gm-Message-State: APjAAAUQE4WlP/a4DG4a465PimXKG8qRXrbNRyXhzg2iTHADmouWo5Lh
 5sjnDQmtp+ENexXn0rG5Vt0attpfIT3yXXRKuyubULBR2Ttd8hw83+ltqSdm4BL/134rzPjS4mq
 ACOa5Lfg2qlqHZHZNonPcdaLJ
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr1342978wrj.301.1571209809459; 
 Wed, 16 Oct 2019 00:10:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVEQNXaAuAJVOUPKU0UPAGNhg1SfcLUKvaqKnrK8g/JFc1UdJaCdRin1J2hoFdoWeTpE0hnA==
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr1342946wrj.301.1571209809203; 
 Wed, 16 Oct 2019 00:10:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e?
 ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id e18sm33448011wrv.63.2019.10.16.00.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 00:10:08 -0700 (PDT)
Subject: Re: [PATCH v5 2/6] ptp: Reorganize ptp_kvm modules to make it
 arch-independent.
To: Jianyong Wu <jianyong.wu@arm.com>, netdev@vger.kernel.org,
 yangbo.lu@nxp.com, john.stultz@linaro.org, tglx@linutronix.de,
 sean.j.christopherson@intel.com, maz@kernel.org, richardcochran@gmail.com,
 Mark.Rutland@arm.com, will@kernel.org, suzuki.poulose@arm.com
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-3-jianyong.wu@arm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0260f51-ad29-02ba-a46f-ebaa68f7a9ea@redhat.com>
Date: Wed, 16 Oct 2019 09:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015104822.13890-3-jianyong.wu@arm.com>
Content-Language: en-US
X-MC-Unique: dC4YZX4XOEGQ1T8VfZKL4w-1
X-Mimecast-Spam-Score: 0
Cc: justin.he@arm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 nd@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 15/10/19 12:48, Jianyong Wu wrote:
> +	ret = kvm_arch_ptp_init();
> +	if (!ret)
> +		return -EOPNOTSUPP;

This should be "if (ret)".

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
